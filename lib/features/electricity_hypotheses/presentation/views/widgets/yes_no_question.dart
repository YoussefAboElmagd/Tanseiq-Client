import 'package:flutter/material.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class YesNoQuestion extends StatelessWidget {
  final String question;
  final String? subtitle;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  final String? thirdOptionValue;
  final String? thirdOptionLabel;

  const YesNoQuestion({
    super.key,
    required this.question,
    this.subtitle,
    required this.groupValue,
    required this.onChanged,
    this.thirdOptionValue,
    this.thirdOptionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: TextStyles.font12Grey),
        if (subtitle != null) ...[
          5.height,
          Text(subtitle!, style: TextStyles.font10Red),
        ],
        Row(
          children: [
            Radio<String>(
              value: 'yes',
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: ColorsManager.mainColor,
            ),
            Text('نعم', style: TextStyles.font12Grey),
            30.width,
            Radio<String>(
              value: 'no',
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: ColorsManager.mainColor,
            ),
            Text('لا', style: TextStyles.font12Grey),
            if (thirdOptionValue != null && thirdOptionLabel != null) ...[
              30.width,
              Radio<String>(
                value: thirdOptionValue!,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: ColorsManager.mainColor,
              ),
              Text(thirdOptionLabel!, style: TextStyles.font12Grey),
            ],
          ],
        ),
      ],
    );
  }
}
