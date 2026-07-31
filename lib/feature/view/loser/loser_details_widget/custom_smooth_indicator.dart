import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../coure/utils/app_colors.dart';

class CustomSmoothIndicator extends StatelessWidget {
  const CustomSmoothIndicator({
    super.key,
    required PageController controller,
    required this.images,
  }) : _controller = controller;

  final PageController _controller;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 260.h,   // responsive height
      left: 160.w,  // responsive width
      child: SmoothPageIndicator(
        controller: _controller,
        count: images.length,
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.primary,
          dotColor: AppColors.captionColor,
          dotHeight: 10.h,  // responsive
          dotWidth: 10.w,   // responsive
          expansionFactor: 3,
        ),
      ),
    );
  }
}