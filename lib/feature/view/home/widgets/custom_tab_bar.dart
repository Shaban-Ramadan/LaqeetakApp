import 'package:flutter/material.dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/sytles.dart';

class CustomTabBar extends StatefulWidget {
  ValueChanged<int> onTabChange;
   CustomTabBar({super.key,required this.onTabChange});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {

 int selectedIndex =0;
  final List<String> tabs = ['الكل', 'موبايلات', 'محفظة', 'ساعات', 'مفاتيح'];
  final List<double> widths = [53, 75, 75, 75, 75];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: List.generate(tabs.length, (index) {
        return InkWell(
          onTap: () {
            setState(() {
             selectedIndex = index;
              print('index:$index');
            });
            widget.onTabChange(index);
          },
          child: Container(
            height: 44,
            width: widths[index],
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:   selectedIndex  == index
                  ? AppColors.primary
                  : AppColors.background, // لون التاب المحدد فقط
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.captionColor, width: 1),
            ),
            child: Text(
              tabs[index],
              style: AppTextStyles.body.copyWith(
                color:   selectedIndex  == index
                    ?AppColors.background
                    : AppColors.captionColor,
              ),
              ),
            ),
        );
      }),
    );
  }
}
