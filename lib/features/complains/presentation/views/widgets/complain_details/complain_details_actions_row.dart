import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/complain_details/complain_escalation_alert.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/complain_details/complains_alert_details.dart';

class ComplainDetailsActionsRow extends StatelessWidget {
  const ComplainDetailsActionsRow({
    super.key,
    required this.cubit,
    required this.id,
  });
  final ComplainsCubit cubit;
  final int id;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          spacing: 10.w,
          children: [
            Expanded(
              child: CustomButton(
                borderRadius: 16.r,
                color: ColorsManager.mainColor,
                textStyle: TextStyles.font14WhiteBold,
                title: 'عدم اخصاص',
                onTap: () {
                  cubit.code = '';
                  cubit.codeController.clear();
                  showDialog(
                    context: context,
                    builder:
                        (context) => ComplainsAlertsDetails(
                          isResolve: false,
                          cubit: cubit,
                          id: id,
                          color: ColorsManager.mainColor,
                          title: 'عدم اختصاص',
                        ),
                  );
                },
              ),
            ),
            Expanded(
              child: CustomButton(
                borderRadius: 16.r,
                color: ColorsManager.green,
                textStyle: TextStyles.font14WhiteBold,
                title: 'تم الاصلاح',
                onTap: () {
                  cubit.code = '';
                  cubit.codeController.clear();
                  showDialog(
                    context: context,
                    builder:
                        (context) => ComplainsAlertsDetails(
                          isResolve: true,
                          id: id,
                          cubit: cubit,
                          color: ColorsManager.green,
                          title: 'تم الاصلاح',
                        ),
                  );
                },
              ),
            ),
            Expanded(
              child: CustomButton(
                borderRadius: 16.r,
                color: ColorsManager.darkRed,
                textStyle: TextStyles.font14WhiteBold,
                title: 'تصعيد',
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) =>
                            ComplainEscalationAlert(id: id, cubit: cubit),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
