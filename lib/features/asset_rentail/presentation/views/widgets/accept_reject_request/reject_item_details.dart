import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_cubit.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/accept_reject_change_item.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/additions_item_design.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/custom_table.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/quantity_area_container_design.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/select_date_location.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/verify_item_design.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/violation.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/work_and_repaire_during_season.dart';

class RejectItemDetails extends StatelessWidget {
  const RejectItemDetails({super.key, required this.cubit});

  final AssetRentailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AcceptRejectChangeItem(cubit: cubit),
        const QuantityAreaContainerDesign(),
        Image.asset(Assets.assetsImagesUploadFile2),
        CustomButton(
          textStyle: TextStyles.font16WhiteBold,
          borderRadius: 12.r,
          color: ColorsManager.green,
          title: 'اصدار مسودة الحصر المبدئي',
          onTap: () {},
        ),
        const SelectDateLocation(),
        const VerifyItemDesign(),
        Text(
          'التشغيل والصيانة اثناء الموسم',
          style: TextStyles.font16BlackBold,
        ),
        const WorkAndRepairDuringSeason(),
        Text('فك الاضافات', style: TextStyles.font16BlackBold),
        const AdditionsItemDesign(),
        Text('المخالفات و الغرامة', style: TextStyles.font16BlackBold),
        const Violation(),
        Image.asset(Assets.assetsImagesUploadFile2),
        CustomButton(
          textStyle: TextStyles.font16WhiteBold,
          borderRadius: 12.r,
          color: ColorsManager.green,
          title: 'حفط',
          onTap: () {},
        ),
        Text('اصدار الفاتورة الختامية', style: TextStyles.font16BlackBold),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: ColorsManager.mainColor),
            boxShadow: const [
              BoxShadow(
                color: ColorsManager.soft3Grey,
                offset: Offset(0, 3),
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            spacing: 10.h,
            children: [
              // const Expanded(
              //   child: CustomTable(),
              // ),
              const CustomTable(),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('الاجمالي', style: TextStyles.font14GreenBold),
                    Text('100 ريال', style: TextStyles.font14SoftBlack),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المخالفات و الغرامة',
                      style: TextStyles.font14GreenBold,
                    ),
                    Text('100 ريال', style: TextStyles.font14SoftBlack),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('صافي', style: TextStyles.font14GreenBold),
                    Text('100 ريال', style: TextStyles.font14SoftBlack),
                  ],
                ),
              ),
            ],
          ),
        ),
        Image.asset(Assets.assetsImagesUploadFile2),
        CustomButton(
          textStyle: TextStyles.font16WhiteBold,
          borderRadius: 12.r,
          color: ColorsManager.green,
          title: 'اصدار فاتورة',
          onTap: () {},
        ),
      ],
    );
  }
}
