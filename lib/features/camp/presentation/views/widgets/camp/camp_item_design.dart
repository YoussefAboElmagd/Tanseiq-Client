import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/camp/data/models/get_all_tent_response_body.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/camp_name.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/camp_progress.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/camp_status.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/camp_tags.dart';

class CampItemDesign extends StatelessWidget {
  const CampItemDesign({super.key, required this.data, this.formMina});

  final TentData data;
  final bool? formMina;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.softGrey,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CampStatus(status: data.completionStatus ?? 'الحالة'),
          10.height,
          CampName(campArea: data.campArea ?? 0, zone: data.zone ?? 'غير محدد'),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مخيم ${data.campNumber ?? ''}',
                style: TextStyles.font14BlackBold,
              ),
              Text(
                'مربع ${data.squareNumber ?? ''}',
                style: TextStyles.font14BlackBold,
              ),
            ],
          ),
          10.height,
          CampProgress(
            progress:
                formMina != null
                    ? data.electricalCampScore ?? 0
                    : data.campWorkScore ?? 0,
          ),
          10.height,
          const CampTags(),
          // 10.height,
          // const Divider(
          //   color: ColorsManager.soft3Grey,
          // ),
          // 10.height,
          // const CampDates(),
        ],
      ),
    );
  }
}
