import 'package:flutter/material.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CampDates extends StatelessWidget {
  const CampDates({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('بدأ في 2021', style: TextStyles.font10Black),
        Text('انتهى في 2022', style: TextStyles.font10Black),
      ],
    );
  }
}
