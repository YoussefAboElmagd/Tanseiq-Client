import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_cubit.dart';

class AcceptRejectChangeItem extends StatelessWidget {
  const AcceptRejectChangeItem({super.key, required this.cubit});

  final AssetRentailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                cubit.changeIndex(0);
              },
              child: Container(
                alignment: Alignment.center,
                height: 35.h,
                decoration: BoxDecoration(
                  color:
                      cubit.selectRequestType == 0
                          ? ColorsManager.mainColor
                          : ColorsManager.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'الخيام',
                  style:
                      cubit.selectRequestType == 0
                          ? TextStyles.font14WhiteBold
                          : TextStyles.font14BlackBold,
                ),
              ),
            ),
          ),
          10.width,
          Expanded(
            child: GestureDetector(
              onTap: () {
                cubit.changeIndex(1);
              },
              child: Container(
                alignment: Alignment.center,
                height: 35.h,
                decoration: BoxDecoration(
                  color:
                      cubit.selectRequestType == 1
                          ? ColorsManager.mainColor
                          : ColorsManager.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'مدني',
                  style:
                      cubit.selectRequestType == 1
                          ? TextStyles.font14WhiteBold
                          : TextStyles.font14BlackBold,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                cubit.changeIndex(2);
              },
              child: Container(
                alignment: Alignment.center,
                height: 35.h,
                decoration: BoxDecoration(
                  color:
                      cubit.selectRequestType == 2
                          ? ColorsManager.mainColor
                          : ColorsManager.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'الكهرباء',
                  style:
                      cubit.selectRequestType == 2
                          ? TextStyles.font14WhiteBold
                          : TextStyles.font14BlackBold,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                cubit.changeIndex(3);
              },
              child: Container(
                alignment: Alignment.center,
                height: 35.h,
                decoration: BoxDecoration(
                  color:
                      cubit.selectRequestType == 3
                          ? ColorsManager.mainColor
                          : ColorsManager.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'الاضافات',
                  style:
                      cubit.selectRequestType == 3
                          ? TextStyles.font14WhiteBold
                          : TextStyles.font14BlackBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
