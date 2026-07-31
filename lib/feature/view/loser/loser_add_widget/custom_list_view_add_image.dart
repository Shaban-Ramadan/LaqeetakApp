import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';

import '../../../view_model/loser_cubit/loser_states.dart';
import 'custom_add_image.dart';

class CustomListViewAddImage extends StatelessWidget {
  const CustomListViewAddImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoserCubit, LoserState>(
      builder: (context, state) {
        var loserCubit = LoserCubit.get(context);
        return SizedBox(
          height: 120.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemCount: loserCubit.loserImages.length,
            itemBuilder: (context, index) {
              return CustomAddImage(index: index);
            },
          ),
        );
      },
    );
  }
}