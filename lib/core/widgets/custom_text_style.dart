import 'package:flutter/material.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CustomTextStyle extends StatelessWidget {
  const CustomTextStyle({
    super.key,
    required this.text1,
    required this.text2,
    this.style1,
    this.style2,
  });
  final String text1;
  final String text2;
  final TextStyle? style1;
  final TextStyle? style2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: text1, style: style1 ?? TextStyles.font16BlackBold),
          TextSpan(text: text2, style: style2 ?? TextStyles.font16GreenBold),
        ],
      ),
    );
  }
}
