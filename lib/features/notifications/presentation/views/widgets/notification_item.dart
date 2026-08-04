import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.image,
    required this.height,
    required this.title,
    required this.index,
  });
  final String image;
  final String title;
  final double height;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: index == 0 ? ColorsManager.white : ColorsManager.soft2MainColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow:
            index == 0
                ? null
                : const [
                  BoxShadow(
                    color: ColorsManager.soft3Grey,
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, width: 30.w),
              10.width,
              Expanded(child: Text(title, style: TextStyles.font14DarkGrey)),
            ],
          ),
          10.height,
          Text('12.21 PM 23-8-2024', style: TextStyles.font14Grey),
          index != 1 ? 0.height : 30.height,
          index != 1
              ? const SizedBox.shrink()
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    width: 105.w,
                    height: 35.h,
                    textStyle: TextStyles.font16WhiteBold,
                    color: ColorsManager.green,
                    borderRadius: 16.r,
                    title: 'موافقة',
                    onTap: () {},
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('رفض', style: TextStyles.font16RedBold),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
