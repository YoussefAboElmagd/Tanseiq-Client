import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class MoreOptionsSurveysRow extends StatelessWidget {
  const MoreOptionsSurveysRow({
    super.key,
    required this.title,
    required this.status,
  });
  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.more_vert_outlined,
            color: ColorsManager.grey,
            size: 28.r,
          ),
        ),
        Text(title, style: TextStyles.font16Grey),
        const Spacer(),
        Container(
          width: 70.w,
          height: 20.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color:
                status.toLowerCase() == 'open'
                    ? ColorsManager.softGreen
                    : ColorsManager.softBurbel,
          ),
          child: Text(
            status.toLowerCase() == 'open' ? 'مفتوح' : 'مغلق',
            style:
                status.toLowerCase() == 'open'
                    ? TextStyles.font12GreenBold
                    : TextStyles.font12BurbelBold,
          ),
        ),
      ],
    );
  }
}
