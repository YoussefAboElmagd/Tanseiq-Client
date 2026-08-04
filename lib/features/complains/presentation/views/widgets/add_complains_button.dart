import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
// import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';

class AddComplainsButton extends StatelessWidget {
  const AddComplainsButton({
    super.key,
    required this.cubit,
    required this.canAdd,
  });

  final ComplainsCubit cubit;
  final bool? canAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        canAdd != null && canAdd == true
            ? Expanded(
              flex: 2,
              child: CustomButton(
                color: ColorsManager.green,
                textStyle: TextStyles.font16WhiteBold,
                borderRadius: 12.r,
                title: 'اضافة بلاغ جديد',
                onTap: () {
                  context.pushNamed(
                    Routes.addComplains,
                    arguments: {
                      'markers': cubit.markers,
                      'isCadana': cubit.currentIndex == 1 ? true : false,
                    },
                  );
                  // context.read<UiCubit>().emitCheckRoute(
                  //   route: Routes.addComplains,
                  //   context: context,
                  //   data: {
                  //     'markers': cubit.markers,
                  //     'isCadana': cubit.currentIndex == 1 ? true : false,
                  //   },
                  // );
                },
              ),
            )
            : const SizedBox.shrink(),
        10.width,
        Expanded(
          child: CustomButton(
            width: 120.w,
            color: ColorsManager.mainColor,
            textStyle: TextStyles.font14WhiteBold,
            borderRadius: 12.r,
            title: 'الاحصائيات',
            onTap: () {
              // print(canAdd);
              context.pushNamed(Routes.complainAnalysis, routerNavigator: true);
            },
          ),
        ),
      ],
    );
  }
}
