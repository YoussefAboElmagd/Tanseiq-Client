import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_cubit.dart';

class DropDownsSelection extends StatelessWidget {
  const DropDownsSelection({super.key, required this.cubit});
  final AssetRentailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      children: [
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
        TextButton(
          onPressed: () {
            print(cubit.campNumberId);
            print(cubit.campNumber);
            print(cubit.rentailCompanyId);
            print(cubit.developerCompanyId);
          },
          child: Text('تخطي', style: TextStyles.font14GreyUnderLine),
        ),
      ],
    );
  }
}
