import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/feature/view/home/widgets/custom_home_app_bar.dart';
import 'package:laqeetak/feature/view/posters/widgets/custom_poster_widget.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_states.dart';

class MyPosterView extends StatefulWidget {
   MyPosterView({super.key});

  @override
  State<MyPosterView> createState() => _MyPosterViewState();
}

class _MyPosterViewState extends State<MyPosterView> {
  @override
  void initState() {
    super.initState();
    final cubit = LoserCubit.get(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = LoserCubit.get(context);
      cubit.getMyPosts();
      cubit.initClickList(cubit.myPosts.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<LoserCubit, LoserState>(
        builder: (BuildContext context, state) {
          var loserCubit = LoserCubit.get(context);

          if (state is FetchLoserDataLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (loserCubit.myPosts.isEmpty) {
            return Center(child: Text('لا توجد منشورات'));
          }

          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 178.h, // responsive
                    color: AppColors.primary,
                  ),
                  CustomHomeAppBar(),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.separated(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemCount: loserCubit.myPosts.length,
                  itemBuilder: (context, index) {
                    // نجيب أول صورة صالحة أو فارغ
                    String imageUrl = '';
                    if (loserCubit.myPosts[index].images != null &&
                        loserCubit.myPosts[index].images!.isNotEmpty) {
                      imageUrl = loserCubit.myPosts[index].images!
                          .firstWhere(
                              (img) => img != null && img.isNotEmpty,
                          orElse: () => '');
                    }
                    return CustomPosterWidget(
                      loserItemModel: loserCubit.myPosts[index],
                      index: index,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


