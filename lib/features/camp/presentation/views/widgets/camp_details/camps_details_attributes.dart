import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
// import 'package:tanseiq/core/widgets/select_date.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_details_response.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_details/camp_details_attributes_item_design.dart';

class CampsDetailsAttributes extends StatelessWidget {
  const CampsDetailsAttributes({super.key, required this.campInfo});
  final GetCampDetailsResponse campInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.softGrey,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        spacing: 20.h,
        children: [
          CampDetailsAttributesItemDesign(
            widget: Row(
              children: [
                Text('رقم المخيم:', style: TextStyles.font14MainColorBold),
                const Spacer(),
                Text(
                  campInfo.campNumber.toString(),
                  style: TextStyles.font14DarkGrey,
                ),
              ],
            ),
          ),
          CampDetailsAttributesItemDesign(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'شركة الخدمات:',
                    style: TextStyles.font14MainColorBold,
                  ),
                ),
                // const Spacer(),
                Expanded(
                  flex: 2,
                  child: Text(
                    campInfo.company ?? 'غير محدد',
                    style: TextStyles.font14DarkGrey,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          CampDetailsAttributesItemDesign(
            widget: Row(
              children: [
                Text('رقم المربع: ', style: TextStyles.font14MainColorBold),
                const Spacer(),
                Text(
                  '${campInfo.squareNumber}',
                  style: TextStyles.font14DarkGrey,
                ),
              ],
            ),
          ),
          CampDetailsAttributesItemDesign(
            widget: Row(
              children: [
                Text('عدد الحجاج:', style: TextStyles.font14MainColorBold),
                const Spacer(),
                Text(
                  '${campInfo.numberOfHajj ?? 0} حاج',
                  style: TextStyles.font14DarkGrey,
                ),
              ],
            ),
          ),
          // Row(
          //   spacing: 10.w,
          //   children: [
          //     Text(
          //       'تاريخ البدأ:',
          //       style: TextStyles.font14MainColorBold,
          //     ),
          //     // const Spacer(),
          //     Expanded(
          //       child: SelectDate(
          //         borderColor: ColorsManager.green,
          //         onChanged: (value) {
          //           Constant.startDate = value;
          //         },
          //         validator: Constant.startDateValidation(context: context),
          //       ),
          //     ),
          //   ],
          // ),
          // Row(
          //   spacing: 10.w,
          //   children: [
          //     Text(
          //       'تاريخ الانتهاء:',
          //       style: TextStyles.font14MainColorBold,
          //     ),
          //     // const Spacer(),
          //     Expanded(
          //       child: SelectDate(
          //         borderColor: ColorsManager.green,
          //         validator: Constant.endDateValidation(
          //           context: context,
          //           startDate: Constant.startDate ?? DateTime.now(),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // CampDetailsAttributesItemDesign(
          //   widget: Row(
          //     spacing: 20.w,
          //     children: [
          //       Text(
          //         'الخدمات:',
          //         style: TextStyles.font14MainColorBold,
          //       ),
          //       const Spacer(),
          //       Container(
          //         height: 25.h,
          //         padding: EdgeInsets.symmetric(
          //           horizontal: 10.w,
          //           vertical: 2.h,
          //         ),
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //           color: ColorsManager.softBurbel,
          //           borderRadius: BorderRadius.circular(10.r),
          //         ),
          //         child: Text(
          //           'مكيف',
          //           style: TextStyles.font12BurbelBold,
          //         ),
          //       ),
          //       Container(
          //         height: 25.h,
          //         padding: EdgeInsets.symmetric(
          //           horizontal: 10.w,
          //           vertical: 2.h,
          //         ),
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //           color: ColorsManager.softGreen,
          //           borderRadius: BorderRadius.circular(10.r),
          //         ),
          //         child: Text(
          //           'ماء',
          //           style: TextStyles.font12GreenBold,
          //         ),
          //       ),
          //       Container(
          //         height: 25.h,
          //         padding: EdgeInsets.symmetric(
          //           horizontal: 10.w,
          //           vertical: 2.h,
          //         ),
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //           color: ColorsManager.softYellow,
          //           borderRadius: BorderRadius.circular(10.r),
          //         ),
          //         child: Text(
          //           'كهرباء',
          //           style: TextStyles.font12YellowBold,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // CampDetailsAttributesItemDesign(
          //   widget: Row(
          //     children: [
          //       Text(
          //         'مدير المشروع:',
          //         style: TextStyles.font14MainColorBold,
          //       ),
          //       const Spacer(),
          //       Text(
          //         'احمد محمد',
          //         style: TextStyles.font14DarkGrey,
          //       ),
          //     ],
          //   ),
          // ),
          // CampDetailsAttributesItemDesign(
          //   widget: Row(
          //     children: [
          //       Text(
          //         'المقاول المسئول:',
          //         style: TextStyles.font14MainColorBold,
          //       ),
          //       const Spacer(),
          //       Text(
          //         'احمد محمد',
          //         style: TextStyles.font14DarkGrey,
          //       ),
          //     ],
          //   ),
          // ),
          // CampDetailsAttributesItemDesign(
          //   widget: Row(
          //     children: [
          //       Text(
          //         'فريق الاستشاري:',
          //         style: TextStyles.font14MainColorBold,
          //       ),
          //       const Spacer(),
          //       Text(
          //         'احمد محمد',
          //         style: TextStyles.font14DarkGrey,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
