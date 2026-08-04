import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_preparing_works_response.dart';

class PrepareTintItem extends StatelessWidget {
  const PrepareTintItem({
    super.key,
    required this.data,
    required this.parentIndex,
    required this.save,
    required this.uploadImage,
    this.fromMina,
    this.canEdit = true,
  });
  final int parentIndex;
  final List<GetCampPreparingWorksResponse> data;
  final dynamic Function() save;
  final dynamic Function() uploadImage;
  final bool? fromMina;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 370.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fromMina != null
                ? data[parentIndex].name ?? 'غير محدد'
                : data[parentIndex].serviceItem?.name ?? 'غير محدد',
            style: TextStyles.font16BlackBold,
          ),
          const Divider(color: ColorsManager.soft3Grey),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('الوحدة', style: TextStyles.font14BlackBold),
                    Text(
                      data[parentIndex].serviceItem?.unit ?? '0',
                      style: TextStyles.font16GreenBold,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('النسبة', style: TextStyles.font14BlackBold),
                    SizedBox(
                      width: 100.w,
                      child: CustomFormField(
                        maxLength: 2,
                        controller: data[parentIndex].completionRateController,
                        contentVerPadding: 4,
                        hintStyle: TextStyles.font14BlackBold,
                        keyboardType: TextInputType.number,
                        hint:
                            fromMina != null
                                ? '${data[parentIndex].compelationRate ?? '0'}'
                                : '${data[parentIndex].completionRate ?? '0'}',
                        isHint: true,
                        validator: (value) {},
                        enabled: canEdit,
                      ),
                    ),
                  ],
                ),
                30.height,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        height: 35.h,
                        color:
                            canEdit
                                ? ColorsManager.green
                                : ColorsManager.soft3Grey,
                        textStyle: TextStyles.font14WhiteBold,
                        title: 'رفع صور',
                        borderRadius: 12.r,
                        onTap: uploadImage,
                      ),
                    ),
                    10.width,
                    fromMina != null
                        ? data[parentIndex].photoUrl == null
                            ? const SizedBox.shrink()
                            : Expanded(
                              child: CustomButton(
                                height: 35.h,
                                // width: 150.w,
                                color: ColorsManager.mainColor,
                                textStyle: TextStyles.font14WhiteBold,
                                title: 'عرض الصورة',
                                borderRadius: 12.r,
                                onTap: () {
                                  context.pushNamed(
                                    Routes.displayNetworkAttachment,
                                    arguments: {
                                      'attachmentPath':
                                          data[parentIndex].photoUrl ?? '',
                                      'extention':
                                          data[parentIndex].photoUrl
                                              ?.split('.')
                                              .last ??
                                          '',
                                    },
                                  );
                                },
                              ),
                            )
                        : data[parentIndex].campWorkPhoto == null
                        ? const SizedBox.shrink()
                        : Expanded(
                          child: CustomButton(
                            height: 35.h,
                            // width: 150.w,
                            color: ColorsManager.mainColor,
                            textStyle: TextStyles.font14WhiteBold,
                            title: 'عرض الصورة',
                            borderRadius: 12.r,
                            onTap: () {
                              context.pushNamed(
                                Routes.displayNetworkAttachment,
                                arguments: {
                                  'attachmentPath':
                                      data[parentIndex].campWorkPhoto ?? '',
                                  'extention':
                                      data[parentIndex].campWorkPhoto
                                          ?.split('.')
                                          .last ??
                                      '',
                                },
                              );
                            },
                          ),
                        ),
                  ],
                ),
                10.height,
              ],
            ),
          ),
          10.height,
          Text('الملاحظات', style: TextStyles.font14Green),
          5.height,
          CustomFormField(
            isHint: true,
            maxLines: 2,
            hint: data[parentIndex].notes ?? 'لا يوجد ملاحظات',
            controller: data[parentIndex].notesController,
            validator: (value) {},
            enabled: canEdit,
          ),
          10.height,
          Align(
            child: CustomButton(
              color:
                  canEdit ? ColorsManager.mainColor : ColorsManager.soft3Grey,
              height: 35.h,
              width: 150.w,
              textStyle: TextStyles.font14WhiteBold,
              title: 'حفظ التعديلات',
              borderRadius: 16.r,
              onTap: canEdit ? save : () {},
            ),
          ),
        ],
      ),
    );
  }
}
