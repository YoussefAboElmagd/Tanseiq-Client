import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class TeamUserItemDesign extends StatelessWidget {
  const TeamUserItemDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.soft3Grey,
            blurRadius: 10.r,
            spreadRadius: 1.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 65.w,
            height: 65.h,
            decoration: const BoxDecoration(
              color: ColorsManager.soft3Grey,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              Assets.assetsImagesProfile,
              width: 35.w,
              height: 35.h,
              color: ColorsManager.grey,
            ),
          ),
          10.width,
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عادل مصطفي',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font16BlackBold,
                ),
                5.height,
                Text(
                  'name123@gmail.com',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font14DarkGrey,
                ),
              ],
            ),
          ),
          // const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              size: 35.r,
              Icons.more_vert,
              color: ColorsManager.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
