import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class HomeRowDescripDesign extends StatelessWidget {
  const HomeRowDescripDesign({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, width: 20.w, height: 20.h),
        10.width,
        Text(title, style: TextStyles.font16SoftBlack),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(color: ColorsManager.mainColor, Icons.more_horiz),
        ),
      ],
    );
  }
}
