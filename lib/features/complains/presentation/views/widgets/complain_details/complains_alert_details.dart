import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_states.dart';

class ComplainsAlertsDetails extends StatelessWidget {
  const ComplainsAlertsDetails({
    super.key,
    required this.title,
    required this.color,
    required this.cubit,
    required this.id,
    required this.isResolve,
  });
  final String title;
  final Color color;
  final ComplainsCubit cubit;
  final int id;
  final bool isResolve;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ComplainsCubit, ComplainsStates>(
        builder: (context, state) {
          var cubit = ComplainsCubit.get(context);
          return Dialog(
            child: SizedBox(
              height: 350.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        controller: cubit.codeController,
                        hint: 'اضافة الكود',
                        borderColor: ColorsManager.soft2Green,
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        validator: Constant.normalValidator(context: context),
                      ),
                      30.height,
                      cubit.code.isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                            alignment: AlignmentDirectional.center,
                            width: 150.w,
                            height: 40.h,
                            padding: EdgeInsets.symmetric(vertical: 10.w),
                            decoration: BoxDecoration(
                              color: ColorsManager.soft2Green,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              'الرمز: ${cubit.code}',
                              style: TextStyles.font16GreenBold,
                            ),
                          ),
                      const Spacer(),
                      state is GetCodeLoadingState
                          ? SizedBox(
                            height: 100.h,
                            width: 100.w,
                            child: circular,
                          )
                          : CustomButton(
                            borderColor: ColorsManager.mainColor,
                            borderRadius: 16.r,
                            textStyle: TextStyles.font14MainColorBold,
                            color: ColorsManager.white,
                            title: 'عرض الكود',
                            onTap: () {
                              cubit.emitGetCode(id: id);
                            },
                          ),
                      10.height,
                      CustomButton(
                        borderRadius: 16.r,
                        textStyle: TextStyles.font16WhiteBold,
                        color: color,
                        title: title,
                        onTap: () {
                          if (cubit.formKey.currentState!.validate()) {
                            isResolve
                                ? cubit.emitResolveProblem(id: id)
                                : cubit.emitUnSpecializedProblem(id: id);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
