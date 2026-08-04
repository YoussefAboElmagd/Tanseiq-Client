import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/more_option_survey_row.dart';

class SurveyItem extends StatelessWidget {
  const SurveyItem({super.key, required this.title, required this.status});
  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w, left: 10.w, top: 30.h),
      width: double.infinity,
      height: 220,
      color: Colors.white,
      child: Column(
        children: [
          MoreOptionsSurveysRow(status: status, title: title),
          10.height,
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorsManager.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.soft3Grey,
                    blurRadius: 10.r,
                    spreadRadius: 1.r,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset(
                width: 100.w,
                height: 100.h,
                color: const Color.fromARGB(255, 238, 237, 237),
                Assets.assetsImagesSurveys,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
