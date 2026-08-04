import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class RentailDetailsTitleRow extends StatelessWidget {
  const RentailDetailsTitleRow({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, width: 20.w, color: ColorsManager.mainColor),
        10.width,
        Text(title, style: TextStyles.font16SoftBlack),
        const Spacer(),
        Image.asset(Assets.assetsImagesImport, width: 20.w),
      ],
    );
  }
}
