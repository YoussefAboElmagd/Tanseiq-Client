import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CloseDialogRow extends StatelessWidget {
  const CloseDialogRow({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title ?? '+اضافة حقل', style: TextStyles.font16BlackBold),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.close, size: 25.r, color: ColorsManager.red),
        ),
      ],
    );
  }
}
