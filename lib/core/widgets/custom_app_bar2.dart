import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({
    super.key,
    required this.globalKey,
    required this.tilte,
  });
  final GlobalKey<ScaffoldState> globalKey;
  final String tilte;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 110.h,
      leading: IconButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
          ),
          backgroundColor: MaterialStateProperty.all(ColorsManager.mainColor),
        ),
        icon: Image.asset(Assets.assetsImagesMenu, width: 20.w, height: 20.h),
        onPressed: () {
          globalKey.currentState!.openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: Image.asset(
            Assets.assetsImagesNotification,
            width: 26.w,
            height: 26.h,
          ),
          onPressed: () {},
        ),
      ],
      floating: true,
      pinned: false,
      title: Text('الاستبيانات', style: TextStyles.font20MainColorBold),
    );
  }
}
