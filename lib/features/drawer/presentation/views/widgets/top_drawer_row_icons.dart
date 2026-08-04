import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';

class TopDrawerRowIcons extends StatelessWidget {
  const TopDrawerRowIcons({super.key, required this.globalKey});

  final GlobalKey<ScaffoldState> globalKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
            ),
            backgroundColor: MaterialStateProperty.all(ColorsManager.mainColor),
          ),
          icon: const Icon(Icons.close, color: ColorsManager.white),
          onPressed: () {
            globalKey.currentState!.closeDrawer();
          },
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            context.read<UiCubit>().emitChangeBottomNav(2);
          },
          icon: Image.asset(
            Assets.assetsImagesSettings,
            width: 30.w,
            height: 30.h,
          ),
        ),
      ],
    );
  }
}
