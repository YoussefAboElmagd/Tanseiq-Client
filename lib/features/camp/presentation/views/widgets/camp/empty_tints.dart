import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';

class EmptyTints extends StatelessWidget {
  const EmptyTints({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100.h),
      child: EmptyList(
        text: 'لا يوجد مخيمات',
        image: Assets.assetsImagesTint,
        imageColor: ColorsManager.mainColor,
        textStyle: TextStyles.font16MainColorBold,
      ),
    );
  }
}
