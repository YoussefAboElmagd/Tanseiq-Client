import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/core/widgets/select_date.dart';

class SelectDateLocation extends StatelessWidget {
  const SelectDateLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.soft3Grey,
            offset: Offset(0, 3),
            blurRadius: 1,
          ),
          BoxShadow(
            color: ColorsManager.soft3Grey,
            offset: Offset(3, 0),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          Text('تحديد موعد النزول للموقع', style: TextStyles.font16BlackBold),
          Text('الطرف المعني', style: TextStyles.font16Grey),
          Row(
            children: [
              Checkbox(
                value: false,
                activeColor: ColorsManager.green,
                onChanged: (value) {},
              ),
              Text('المطور', style: TextStyles.font16MainColorBold),
              Checkbox(
                value: false,
                activeColor: ColorsManager.green,
                onChanged: (value) {},
              ),
              Text('شركة الخدمة', style: TextStyles.font16MainColorBold),
            ],
          ),
          SelectDate(),
          CustomFormField(hint: 'الوصف', maxLines: 4, validator: (value) {}),
          Image.asset(Assets.assetsImagesUploadFile2),
          CustomButton(
            textStyle: TextStyles.font16WhiteBold,
            borderRadius: 12.r,
            color: ColorsManager.green,
            title: 'ارسال',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
