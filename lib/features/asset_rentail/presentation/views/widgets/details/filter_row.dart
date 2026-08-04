import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_cubit.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/details/rentail_filter_dialog.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key, required this.cubit});
  final AssetRentailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.assetsImagesContracts,
          width: 20.w,
          color: ColorsManager.mainColor,
        ),
        10.width,
        Text('الطلبات', style: TextStyles.font16SoftBlack),
        const Spacer(),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => RentailFilterDialog(cubit: cubit),
            );
          },
          child: Container(
            width: 35.w,
            height: 35.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: const [
                BoxShadow(
                  color: ColorsManager.soft3Grey,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset(Assets.assetsImagesFilter, width: 25.w),
          ),
        ),
      ],
    );
  }
}
