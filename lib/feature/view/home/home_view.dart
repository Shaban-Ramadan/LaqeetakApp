import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/feature/model/loser_model.dart';
import 'package:laqeetak/feature/view/home/widgets/custom_carouserl_slider.dart';
import 'package:laqeetak/feature/view/home/widgets/custom_home_app_bar.dart';
import 'package:laqeetak/feature/view/home/widgets/custom_home_search_field.dart';
import 'package:laqeetak/feature/view/home/widgets/custom_loser_widget.dart';
import 'package:laqeetak/feature/view/home/widgets/custom_tab_bar.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_states.dart';
import '../../../coure/utils/app_colors.dart';
import '../loser/loser_add__view.dart';
import '../more/more_view.dart';
import '../posters/my_poster.dart';
import '../search/search_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: BlocBuilder<LoserCubit, LoserState>(
          builder: (BuildContext context, state) {
            var loserCubit = LoserCubit.get(context);
            print(loserCubit.displayedItems.length);
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 178.h, // متناسب
                  color: AppColors.primary,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 210.h, // متناسب
                    right: 10.w,
                    left: 10.w,
                  ),
                  child: Column(
                    children: [
                      CustomCarouselSlider(),
                      SizedBox(height: 10,),
                      CustomTabBar(
                        onTabChange: (value) {
                          loserCubit.filterItemsByTab(value);
                        },
                      ),
                      Expanded(
                        child: state is FetchLoserDataLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : loserCubit.displayedItems.isEmpty
                                ? Center(child: Text('لا توجد مفقودات'))
                                : GridView.builder(
                                    itemCount: loserCubit.displayedItems.length,
                                    itemBuilder: (context, index) =>
                                        CustomLoserWidget(
                                            item: loserCubit
                                                .displayedItems[index]),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10.w,
                                      mainAxisSpacing: 10.h,
                                          childAspectRatio: 0.7.h,
                                        ),
                                  ),
                      )
                    ],
                  ),
                ),
                CustomHomeAppBar(),
                CustomHomeSearchField(
                  onChanged: (value) {
                    loserCubit.homeSearchItems(value);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeView(),
    SearchView(),
    AddLostView(),
    MyPosterView(),
    MoreView()
  ];

  @override
  void initState() {
    super.initState();
    LoserCubit.get(context).fetchLoserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
          selectedFontSize: 20.sp,
          unselectedFontSize: 16.sp,
          selectedIconTheme: IconThemeData(
            size: 30.r,
            shadows: [],
          ),
          unselectedIconTheme: IconThemeData(
            size: 28.r,
          ),
          backgroundColor: AppColors.background,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.captionColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'بحث',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'إضافة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              label: 'منشور',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.read_more),
              label: 'المزيد',
            ),
          ],
        ),
      ),
    );
  }
}
