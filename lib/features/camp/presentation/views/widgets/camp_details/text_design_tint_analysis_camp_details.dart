import 'package:flutter/material.dart';
import 'package:tanseiq/core/theming/styles.dart';

class TextDesignTintAnalysisCampDetials extends StatelessWidget {
  const TextDesignTintAnalysisCampDetials({
    super.key,
    required this.text1,
    required this.text2,
    required this.textStyle1,
  });
  final String text1;
  final String text2;
  final TextStyle textStyle1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text1, style: textStyle1),
        Text(text2, style: TextStyles.font16Grey),
      ],
    );
  }
}
