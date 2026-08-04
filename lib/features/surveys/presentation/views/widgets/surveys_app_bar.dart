import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';

class SurveysAppBar extends StatelessWidget {
  const SurveysAppBar({
    super.key,
    // required this.globalKey,
    required this.onTap,
  });
  // final GlobalKey<ScaffoldState> globalKey;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 110.h,
      actions: [
        IconButton(
          icon: Image.asset(
            Assets.assetsImagesNotification,
            width: 26.w,
            height: 26.h,
          ),
          onPressed: () {
            context.pushNamed(Routes.notifications);
          },
        ),
      ],
      floating: true,
      pinned: false,
      title: Text('الاستبيانات', style: TextStyles.font20MainColorBold),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: CustomButton(title: '+إضافة استبيان', onTap: onTap),
        ),
      ),
    );
  }
}
