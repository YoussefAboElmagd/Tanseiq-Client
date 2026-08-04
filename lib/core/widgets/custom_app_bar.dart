import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';

AppBar customAppBar({required BuildContext context, required String title}) =>
    AppBar(
      leading: const ArrowBack(),
      title: Text(title, style: TextStyles.font18MainColorBold),
      actions: [
        IconButton(
          icon: Image.asset(
            Assets.assetsImagesNotification,
            width: 22.w,
            height: 22.h,
          ),
          onPressed: () {
            context.pushNamed(Routes.notifications);
          },
        ),
      ],
    );
