import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/views/widgets/reports_details_item.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: double.infinity,
      height: 450.h,
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
                  Assets.assetsImagesReports,
                  width: 25.w,
                  height: 25.h,
                ),
              ),
              10.width,
              Text('تقارير', style: TextStyles.font18BlackBold),
            ],
          ),
          20.height,
          Text('مهم', style: TextStyles.font14SoftBlackBold),
          20.height,
          const ReportsDetailsItem(),
          Text('آخر', style: TextStyles.font14SoftBlackBold),
          10.height,
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => const ReportsDetailsItem(),
              itemCount: 2,
            ),
          ),
          const Divider(color: ColorsManager.mainColor),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {},
              child: Text('مشاهدة الكل', style: TextStyles.font14MainColorBold),
            ),
          ),
        ],
      ),
    );
  }
}
