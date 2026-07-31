import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../coure/utils/app_images.dart';
class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Image(
          image: AssetImage(AppImages.courserImage),
          width: double.infinity.w,
          height: 140.h,
          fit: BoxFit.cover,
        ),
      ],
      options: CarouselOptions(
        autoPlay: true,
        height: 120.h,
        clipBehavior: Clip.none,
        viewportFraction: 1,
      ),
    );
  }
}