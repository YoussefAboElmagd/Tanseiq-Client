import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';

class SelectComplainsTypeRow extends StatelessWidget {
  const SelectComplainsTypeRow({super.key, required this.cubit});

  final ComplainsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Expanded(
          child: CustomButton(
            height: 40.h,
            color:
                cubit.currentIndex == 0
                    ? ColorsManager.green
                    : ColorsManager.soft3Grey,
            textStyle: TextStyles.font16WhiteBold,
            borderRadius: 12.r,
            title: 'البلاغات',
            onTap: () {
              // context.pushNamed(Routes.displayMyComplains);
              cubit.changeIndex(0);
              cubit.page = 0;
              cubit.emitGetAllProblems();
            },
          ),
        ),
        Expanded(
          child: CustomButton(
            height: 40.h,
            color:
                cubit.currentIndex == 1
                    ? ColorsManager.green
                    : ColorsManager.softGrey,
            textStyle: TextStyles.font16WhiteBold,
            borderRadius: 12.r,
            title: 'بلاغات كدانة',
            onTap: () {
              cubit.changeIndex(1);
              cubit.page = 0;
              cubit.emitGetAllProblemCadana();
            },
          ),
        ),
      ],
    );
  }
}
