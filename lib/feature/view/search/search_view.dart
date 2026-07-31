import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/feature/view/home/widgets/custom_home_search_field.dart';
import 'package:laqeetak/feature/view/home/widgets/custom_loser_widget.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_states.dart';
import '../../model/loser_model.dart';
import '../home/widgets/custom_home_app_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
    LoserCubit.get(context).initSearch();
  }

  @override
  Widget build(BuildContext context) {
    var loserCubit = LoserCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<LoserCubit, LoserState>(
        builder: (context, state) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 178.h,
                color: AppColors.primary,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 210.h,
                  start: 10.w,
                  end: 10.w,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: state is FetchLoserDataLoadingState
                          ? Center(child: CircularProgressIndicator())
                          : GridView.builder(
                              itemCount: loserCubit.searchViewResults.length,
                              itemBuilder: (context, index) =>
                                  CustomLoserWidget(
                                item: LoserItemModel(
                                  itemId: loserCubit
                                      .searchViewResults[index].itemId,
                                  ownerId: loserCubit
                                      .searchViewResults[index].ownerId,
                                  title:
                                      loserCubit.searchViewResults[index].title,
                                  description: loserCubit
                                      .searchViewResults[index].description,
                                  category: loserCubit
                                      .searchViewResults[index].category,
                                  date:
                                      loserCubit.searchViewResults[index].date,
                                  latitude: loserCubit
                                      .searchViewResults[index].latitude,
                                  longitude: loserCubit
                                      .searchViewResults[index].longitude,
                                  locationName: loserCubit
                                      .searchViewResults[index].locationName,
                                  images: loserCubit
                                      .searchViewResults[index].images,
                                ),
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: 0.8,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              CustomHomeAppBar(),
              CustomHomeSearchField(
                onChanged: (value) {
                  loserCubit.viewSearchItem(value);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
