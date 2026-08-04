import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/base/presentation/views/widget/bottom_navigation_bar_item_button.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.cubit});

  final UiCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: AlignmentDirectional.center,
      height: MediaQuery.sizeOf(context).height * 0.1,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.mainColor, width: 1.w),
        borderRadius: BorderRadius.circular(50.r),
        color: ColorsManager.white,
      ),
      child: BottomNavigationBarItemButton(cubit: cubit),
    );
  }
}
