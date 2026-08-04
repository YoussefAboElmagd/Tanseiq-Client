import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/hypothesis/presentation/manager/hypothesis_cubit.dart';

class HypothesisChangeItem extends StatelessWidget {
  const HypothesisChangeItem({super.key, required this.cubit});

  final HypothesisCubit cubit;

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
                      cubit.currentIndex == 0
                          ? ColorsManager.mainColor
                          : ColorsManager.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'فرضيات الماء',
                  style:
                      cubit.currentIndex == 0
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
                      cubit.currentIndex == 1
                          ? ColorsManager.mainColor
                          : ColorsManager.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'فرضيات الكهرباء',
                  style:
                      cubit.currentIndex == 1
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
