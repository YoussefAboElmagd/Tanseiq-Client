import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';

class CustomAppBarSlivers extends StatelessWidget {
  const CustomAppBarSlivers({
    super.key,
    required this.tilte,
    this.displayArrow,
    this.displayNotificationIcon,
  });
  final String tilte;
  final bool? displayArrow;
  final bool? displayNotificationIcon;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 60.h,
      leading:
          displayArrow == null ? const SizedBox.shrink() : const ArrowBack(),
      actions: [
        displayNotificationIcon != null
            ? const SizedBox.shrink()
            : IconButton(
              icon: Image.asset(
                Assets.assetsImagesNotification,
                width: 25.w,
                height: 25.h,
              ),
              onPressed: () {
                context.pushNamed(Routes.notifications);
              },
            ),
      ],
      floating: true,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(
          right: displayArrow == null ? 10.w : 50.w,
          bottom: 20.h,
        ),
        title: Text(tilte, style: TextStyles.font14MainColorBold),
      ),
    );
  }
}
