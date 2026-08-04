import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';

class TintNameRow extends StatelessWidget {
  const TintNameRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30.w,
          height: 30.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Image.asset(Assets.assetsImagesDoc, width: 20.w),
        ),
        10.width,
        Text('خيمة رقم', style: TextStyles.font14BlackBold),
        10.width,
        SizedBox(
          width: 50.w,
          child: CustomFormField(
            isHint: true,
            hintStyle: TextStyles.font14Grey,
            contentVerPadding: 5.h,
            hint: '4-4',
            validator: (value) {},
          ),
        ),
      ],
    );
  }
}
