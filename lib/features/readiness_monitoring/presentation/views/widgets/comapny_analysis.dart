import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_reponse.dart';

class CompanyAnalysis extends StatelessWidget {
  const CompanyAnalysis({super.key, required this.company});
  final List<GetCampAnalysisReponse> company;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: double.infinity,
      height: 500.h,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.softGrey,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
          BoxShadow(
            color: ColorsManager.softGrey,
            blurRadius: 5,
            offset: Offset(5, 0),
          ),
        ],
        border: Border.all(color: ColorsManager.mainColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorsManager.softGrey.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  Assets.assetsImagesCompany,
                  width: 25.w,
                  height: 25.h,
                ),
              ),
              10.width,
              Text('شركات تقديم الخدمة', style: TextStyles.font18BlackBold),
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder:
                  (context, index) =>
                      const Divider(color: ColorsManager.soft3Grey),
              itemCount: company.length,
              itemBuilder:
                  (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      spacing: 10.h,
                      children: [
                        Row(
                          spacing: 7.w,
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 8.r,
                                backgroundColor: getPercentage(
                                  company[index].totalCompletionPercentage /
                                      100,
                                ),
                              ),
                            ),
                            Text(
                              company[index].companyName ??
                                  'اسم الشركة غير محدد',
                              style: TextStyles.font14SoftBlackBold,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              '${company[index].totalCompletionPercentage}%',
                              style: TextStyles.font14SoftBlackBold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          lineHeight: 5.h,
                          barRadius: Radius.circular(10.r),
                          percent:
                              company[index].totalCompletionPercentage / 100,
                          backgroundColor: ColorsManager.grey.withOpacity(0.7),
                          progressColor: getPercentage(
                            company[index].totalCompletionPercentage / 100,
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Color getPercentage(double value) {
    if (value > 0.7) {
      return ColorsManager.green;
    } else if (value > 0.5 && value < 0.7) {
      return ColorsManager.yellow;
    } else {
      return ColorsManager.darkRed;
    }
  }
}

// http://147.93.55.107:5237/System/Term/GetCampWorkScoreOfTermClassifications?RentalCompany=0&ZoneId=0
// http://147.93.55.107:5237/System/Term/GetCampWorkScoreOfTermClassifications?RentalCompany=0&ZoneId=0&Status=0&ModifiedDate=2025-07-30T00%3A00%3A00.000
//
