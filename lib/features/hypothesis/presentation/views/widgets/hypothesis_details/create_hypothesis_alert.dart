import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_reading_by_time.dart';
import 'package:tanseiq/features/hypothesis/presentation/views/widgets/hypothesis_item_design.dart';
import 'package:tanseiq/features/recording_readings/presentation/manager/recording_readings_cubit.dart';

class CreateHypothesisAlert extends StatelessWidget {
  const CreateHypothesisAlert({
    super.key,
    required this.cubit,
    required this.data,
  });
  final RecordingReadingsCubit cubit;
  final GetGeneratorsReadingByTime data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 620.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              spacing: 20.h,
              children: [
                Text('تسحيل القراءة', style: TextStyles.font16BlackBold),
                const Divider(color: ColorsManager.soft3Grey),
                HypothesisItemDesign(
                  title: 'المحول ${data.generatorSerial ?? 'غير محدد'}',
                ),
                Row(
                  spacing: 15.w,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('B', style: TextStyles.font14Black),
                          CustomFormField(
                            keyboardType: TextInputType.number,
                            controller: cubit.bController,
                            contentVerPadding: 14.h,
                            hintStyle: TextStyles.font14Black,
                            hint: '0',
                            isHint: true,
                            validator: Constant.normalValidator(
                              context: context,
                              warning: '',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Y', style: TextStyles.font14Black),
                          CustomFormField(
                            keyboardType: TextInputType.number,
                            controller: cubit.yController,
                            hintStyle: TextStyles.font14Black,
                            hint: '0',
                            isHint: true,
                            validator: Constant.normalValidator(
                              context: context,
                              warning: '',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('R', style: TextStyles.font14Black),
                          CustomFormField(
                            keyboardType: TextInputType.number,
                            controller: cubit.rController,
                            hintStyle: TextStyles.font14Black,
                            hint: '0',
                            isHint: true,
                            validator: Constant.normalValidator(
                              context: context,
                              warning: '',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    cubit.emitPickImage(context: context);
                  },
                  child: Image.asset(Assets.assetsImagesAddImage2),
                ),
                50.height,
                CustomButton(
                  title: 'تسجيل',
                  onTap: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.emitSaveReading(
                        context,
                        data.readings![0].generatorId ?? 1,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
