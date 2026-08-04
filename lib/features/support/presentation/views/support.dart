import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar_slivers.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/core/widgets/review_and_delete_attachment_row.dart';
import 'package:tanseiq/features/support/presentation/manager/support_cubit.dart';
import 'package:tanseiq/features/support/presentation/manager/support_states.dart';
import 'package:tanseiq/features/support/presentation/views/widgets/support_bloc_listenrer.dart';
import 'package:tanseiq/features/support/presentation/views/widgets/support_user_details_item.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportCubit, SupportStates>(
      builder: (context, state) {
        var cubit = SupportCubit.get(context);
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              const CustomAppBarSlivers(tilte: 'التواصل والدعم'),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Assets.assetsImagesSupport,
                                width: 40.w,
                                height: 40.h,
                              ),
                              5.width,
                              Text(
                                'نحن في انتظاركم',
                                style: TextStyles.font22MainColorBold,
                              ),
                            ],
                          ),
                          10.height,
                          Text(
                            'لا تتردد في ترك رسالة لنا بخصوص مشكلتك أو اقتراحك وسوف يقوم فريق الدعم بالرد عليك',
                            style: TextStyles.font14Black,
                          ),
                          40.height,
                          Text('الاسم', style: TextStyles.font14Grey),
                          5.height,
                          SupportUserDetailItem(
                            data: CachHelper.getData(key: 'uname'),
                          ),
                          20.height,
                          5.height,
                          Text('الايميل', style: TextStyles.font14Grey),
                          SupportUserDetailItem(
                            data: CachHelper.getData(key: 'uname'),
                          ),
                          20.height,
                          Text('الرسالة', style: TextStyles.font14Grey),
                          5.height,
                          CustomFormField(
                            controller: cubit.messageController,
                            maxLines: 8,
                            hint: '',
                            validator: Constant.normalValidator(
                              context: context,
                            ),
                          ),
                          40.height,
                          GestureDetector(
                            onTap: () {
                              cubit.emitPickAttachment(context: context);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  Assets.assetsImagesUploadFile,
                                  width: 30.w,
                                ),
                                10.width,
                                Text(
                                  'اضافة مرفق',
                                  style: TextStyles.font18GreenBold,
                                ),
                                const Spacer(),
                                cubit.attachment != null
                                    ? ReviewAndDeleteAttachmentRow(
                                      extention:
                                          cubit.attachment!.path
                                              .split('.')
                                              .last,
                                      path: cubit.attachment!.path,
                                      deleteButton:
                                          () => cubit.deleteAttachment(),
                                    )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          40.height,
                          CustomButton(
                            color:
                                cubit.supportExt.contains(cubit.extention) ||
                                        cubit.attachment == null
                                    ? ColorsManager.mainColor
                                    : ColorsManager.darkRed,
                            textStyle: TextStyles.font16WhiteBold,
                            title:
                                cubit.supportExt.contains(cubit.extention) ||
                                        cubit.attachment == null
                                    ? 'ارسال'
                                    : 'المرفق غير مدعوم',
                            onTap: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.emitAddSupportMessage(
                                  name: CachHelper.getData(key: 'uname'),
                                  email: CachHelper.getData(key: 'uname'),
                                  context: context,
                                );
                              }
                            },
                          ),
                          const SupportBlocListenrer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
