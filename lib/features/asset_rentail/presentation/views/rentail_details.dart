import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/details/pdf_button_design.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/details/rentail_details_attributes.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/details/rentail_details_design_item.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/details/rentail_details_title_row.dart';

class RentailDetails extends StatelessWidget {
  const RentailDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'تأجير الاصول'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10.h,
              children: [
                const RentailDetailsTitleRow(
                  title: 'مطوره جنوب اسيا',
                  image: Assets.assetsImagesLocation,
                ),
                10.height,
                CustomButton(
                  borderRadius: 12.r,
                  textStyle: TextStyles.font16WhiteBold,
                  title: 'متابعة الطلبات',
                  onTap: () {
                    context.pushNamed(Routes.trackRentail);
                  },
                ),
                const RentailDetailDesignItem(
                  text1: 'مساحات المؤجرة :',
                  text2: 'متر مربع 2600',
                ),
                const RentailDetailDesignItem(
                  text1: 'المناطق المرفوضة :',
                  text2: '100',
                ),
                const RentailDetailDesignItem(
                  text1: 'المناطق المؤجرة:',
                  text2: '300',
                ),
                const RentailDetailDesignItem(
                  text1: 'عدد الحجاج:',
                  text2: '1,325,366حج',
                ),
                Image.asset(Assets.assetsImagesDisplayComplaun),
                Container(
                  width: double.infinity,
                  height: 750.h,
                  margin: EdgeInsets.only(bottom: 10.h, left: 5.h, right: 5.h),
                  padding: EdgeInsets.only(
                    bottom: 20.h,
                    left: 10.h,
                    right: 10.h,
                    top: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: const [
                      BoxShadow(
                        color: ColorsManager.soft3Grey,
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5.h,
                    children: [
                      Text('16/649', style: TextStyles.font18MainColorBold),
                      Text(
                        'إثراء الجود -روسيا',
                        style: TextStyles.font14MainColor,
                      ),
                      const Divider(color: ColorsManager.soft3Grey),
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder:
                              (context, index) =>
                                  RentailDetailsAttributes(index: index),
                          itemCount: 19,
                        ),
                      ),
                      const PdfButtonDesign(
                        title: 'كروكي التسليم ............pdf',
                      ),
                      const PdfButtonDesign(title: 'تخصيص الوزارة……….pdf'),
                      // CustomButton(title: title, onTap: onTap),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
