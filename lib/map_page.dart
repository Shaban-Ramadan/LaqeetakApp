import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/coure/widgets/button_custom(1).dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_states.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoserCubit, LoserState>(
      builder: (context, state) {
        final cubit = LoserCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: const Text('اختيار الموقع'),
            titleTextStyle: AppTextStyles.subHeading.copyWith(
              color: AppColors.background,
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              /// الخريطة
              FlutterMap(
                mapController: cubit.mapController,
                options: MapOptions(
                  initialCenter: const LatLng(30.0444, 31.2357),
                  initialZoom: 13,
                  onTap: (tapPosition, point) {
                    /// a اخذ بيانات المكان
                    cubit.loserPickLocation(point);
                    cubit.clearSearchResults(); //// نخفي التوقعات
                    Navigator.pop(context, {
                      'lat': cubit.latitude,
                      'lng': cubit.longitude,
                      'name': cubit.loserLocationSearchController.text,
                    });

                  },
                  onPositionChanged: (position, hasGesture) {
                    if (hasGesture && position.center != null) {
                      cubit.updateCenter(position.center!);
                    }
                  },
                ),
                children: [
                  ///  Tiles
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.example.laqeetak',
                  ),
                ],
              ),

              ///  حقل البحث
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      child: TextField(
                        controller: cubit.loserLocationSearchController,
                        decoration: const InputDecoration(
                          hintText: 'ابحث عن مكان...',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                        onChanged: (value) {
                          cubit.searchLoserLocations(value);
                        },
                      ),
                    ),

                    ///  نتائج البحث (Autocomplete)
                    if (cubit.searchResults.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: cubit.searchResults.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final place = cubit.searchResults[index];

                            return ListTile(
                              leading: const Icon(
                                Icons.location_on_outlined,
                                color: AppColors.primary,
                              ),
                              title: Text(
                                place['display_name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.body,
                              ),
                              onTap: () {
                                /// تحديد المكان
                                cubit.selectSearchedLocation(place);
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),

              ///  زر حفظ الموقع
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: CustomButton(
                  onPressed: cubit.loserLocation == null
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: AppColors.red,
                              content: Center(
                                child: Text('من فضلك ختر موقع '),
                              )));
                        }
                      : () {
                    cubit.saveLocation();
                    Navigator.pop(context, {
                      'lat': cubit.latitude,
                      'lng': cubit.longitude,
                      'name': cubit.loserLocationSearchController.text,
                    });
                        },
                  text: Text(
                    'حفظ الموقع',
                    style: AppTextStyles.subHeading.copyWith(
                      color: AppColors.background,
                    ),
                  ),
                  color: AppColors.primary,
                  height: 48,
                  width: double.infinity,
                ),
              ),

              /// Marker ثابت في منتصف الشاشة
              Center(
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
