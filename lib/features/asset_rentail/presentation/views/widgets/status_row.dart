import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class StatusRow extends StatelessWidget {
  const StatusRow({
    super.key,
    required this.requestNumber,
    required this.state,
    required this.isRejected,
  });
  final String requestNumber;
  final String state;
  final bool isRejected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('رقم الطلب:', style: TextStyles.font14MainColorBold),
        Text(requestNumber, style: TextStyles.font14BlackBold),
        10.width,
        Expanded(
          child: Container(
            height: 26.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isRejected ? ColorsManager.red : ColorsManager.green,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(state, style: TextStyles.font12WhiteBold),
          ),
        ),
      ],
    );
  }
}
