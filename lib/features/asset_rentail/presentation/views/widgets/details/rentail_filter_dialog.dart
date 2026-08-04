import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_cubit.dart';

class RentailFilterDialog extends StatelessWidget {
  const RentailFilterDialog({super.key, required this.cubit});

  final AssetRentailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: SizedBox(
          height: 400.h,
          child: Column(
            spacing: 10.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('تصفية', style: TextStyles.font18MainColorBold),
              20.height,
              // DropDownListSearchId(
              //   textEditingController: TextEditingController(),
              //   hintTextStyle: TextStyles.font14SoftBlack,
              //   iconColor: ColorsManager.mainColor,
              //   radiusBottomLeft: 5.r,
              //   radiusBottomRight: 5.r,
              //   radiusTopLeft: 5.r,
              //   radiusTopRight: 5.r,
              //   text: 'شركة مطورة',
              //   list: cubit.developerCompany,
              //   selectedValue: cubit.developerCompanyId,
              //   onChanged: (value, text) {
              //     cubit.developerCompanyId = value!;
              //   },
              // ),
              DropDownListSearchId(
                textEditingController: TextEditingController(),
                hintTextStyle: TextStyles.font14SoftBlack,
                iconColor: ColorsManager.mainColor,
                radiusBottomLeft: 5.r,
                radiusBottomRight: 5.r,
                radiusTopLeft: 5.r,
                radiusTopRight: 5.r,
                text: 'شركة خدمة',
                list: cubit.rentailCompany,
                selectedValue: cubit.rentailCompanyId,
                onChanged: (value, text) {
                  cubit.rentailCompanyId = value!;
                },
              ),
              DropDownListSearchId(
                textEditingController: TextEditingController(),
                hintTextStyle: TextStyles.font14SoftBlack,
                iconColor: ColorsManager.mainColor,
                radiusBottomLeft: 5.r,
                radiusBottomRight: 5.r,
                radiusTopLeft: 5.r,
                radiusTopRight: 5.r,
                text: 'رقم المخيم',
                list: cubit.campNumbers,
                selectedValue: cubit.campNumberId,
                onChanged: (value, text) {
                  cubit.campNumberId = value!;
                  cubit.campNumber = text.name;
                },
              ),
              const Spacer(),
              CustomButton(
                color: ColorsManager.green,
                textStyle: TextStyles.font16WhiteBold,
                title: 'تصفية',
                onTap: () {
                  context.pop();
                  cubit.selectRequestType == 0
                      ? cubit.emitGetAllAssets()
                      : cubit.emitGetRejectedAssets();
                },
              ),
              cubit.campNumberId.isNotEmpty ||
                      cubit.rentailCompanyId.isNotEmpty ||
                      cubit.developerCompanyId.isNotEmpty
                  ? TextButton(
                    onPressed: () {
                      context.pop();
                      cubit.emitClearAll();
                      cubit.selectRequestType == 0
                          ? cubit.emitGetAllAssets()
                          : cubit.emitGetRejectedAssets();
                    },
                    child: Text('ارجاع', style: TextStyles.font16RedBold),
                  )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
