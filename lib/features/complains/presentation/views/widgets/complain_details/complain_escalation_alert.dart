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

class ComplainEscalationAlert extends StatelessWidget {
  const ComplainEscalationAlert({
    super.key,
    required this.cubit,
    required this.id,
  });
  final ComplainsCubit cubit;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ComplainsCubit, ComplainsStates>(
        builder: (context, state) {
          var cubit = ComplainsCubit.get(context);
          return Dialog(
            child: SizedBox(
              height: cubit.image == null ? 300.h : 450.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        maxLines: 3,
                        hint: 'اضافة سبب',
                        controller: cubit.escalationReason,
                        borderColor: ColorsManager.soft2Green,
                        validator: Constant.normalValidator(context: context),
                      ),
                      10.height,
                      cubit.image == null
                          ? const SizedBox.shrink()
                          : Container(
                            height: 150.h,
                            width: double.infinity,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Image.file(cubit.image!, fit: BoxFit.cover),
                          ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              cubit.emitPickOneImage(context: context);
                            },
                            child: Text(
                              cubit.image == null ? 'اضافة صورة' : 'تغيير صورة',
                              style: TextStyles.font16MainColorBold,
                            ),
                          ),
                          cubit.image == null
                              ? const SizedBox.shrink()
                              : TextButton(
                                onPressed: () {
                                  cubit.clearFiles();
                                },
                                child: Text(
                                  'حذف صورة',
                                  style: TextStyles.font16DarkRedBold,
                                ),
                              ),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        borderRadius: 16.r,
                        color: ColorsManager.darkRed,
                        textStyle: TextStyles.font16WhiteBold,
                        title: 'تصعيد',
                        onTap: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.emitSaveComment(id: id);
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
