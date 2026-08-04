import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_network_image.dart';
import 'package:tanseiq/core/widgets/custom_text_style.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_reponse.dart';

class CampDataAnalysis extends StatelessWidget {
  const CampDataAnalysis({
    super.key,
    required this.campAnalysis,
    required this.zoneId,
  });
  final GetCampAnalysisReponse campAnalysis;
  final int zoneId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Expanded(
          child: Row(
            spacing: 10,
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: 50.w,
                  height: 50.h,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CustomNetworkImage(
                    errorImage: Assets.assetsImagesTint,
                    image: campAnalysis.logo ?? '',
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  campAnalysis.companyName ?? 'غير محدد',
                  style: TextStyles.font14BlackBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        CustomTextStyle(
          style1: TextStyles.font14Grey,
          style2: TextStyles.font14MainColorBold,
          text1: 'عدد المخيمات',
          text2:
              ' ${zoneId == 0
                  ? campAnalysis.totalNumberOfCamps
                  : zoneId == 1
                  ? campAnalysis.totalNumberOfCampsBasedOnMina
                  : campAnalysis.totalNumberOfCampsBasedOnArafat ?? '0'}',
        ),
        CustomTextStyle(
          style1: TextStyles.font14Grey,
          style2: TextStyles.font14MainColorBold,
          text1: 'نسبة الانجاز',
          text2:
              ' ${zoneId == 0
                  ? campAnalysis.totalCompletionPercentage
                  : zoneId == 1
                  ? campAnalysis.totalCompletionPercentageBasedOnMina
                  : campAnalysis.totalCompletionPercentageBasedOnArafat ?? '0'}%',
        ),
      ],
    );
  }
}
