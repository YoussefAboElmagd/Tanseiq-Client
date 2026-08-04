import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/complains/data/models/get_all_complains_response.dart';

class ComplainItemDesign extends StatelessWidget {
  const ComplainItemDesign({super.key, required this.data});
  final ComplainsData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.mainColor),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data.address ?? '',
                  style: TextStyles.font14SoftBlack,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 90.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: ColorsManager.mainColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  data.statusCode ?? 'لم يحدد',
                  style: TextStyles.font12WhiteBold,
                ),
              ),
            ],
          ),
          const Divider(color: ColorsManager.soft3Grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'رقم المخيم : ${data.camp ?? 'لم يحدد'}',
                style: TextStyles.font14SoftBlack,
              ),
              Text(
                'المخيم : ${data.campId ?? 'لم يحدد'}',
                style: TextStyles.font14SoftBlack,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'رقم المنطقة : ${data.zoneId ?? 'لم يحدد'}',
                style: TextStyles.font14SoftBlack,
              ),
              Text(
                'المنطقة : ${data.zone ?? 'لم يحدد'}',
                style: TextStyles.font14SoftBlack,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'رقم المشكلة : ${data.problemTypeCode ?? 'لم يحدد'}',
                style: TextStyles.font14SoftBlack,
              ),
              Text(
                'المشكلة : ${data.problemType ?? 'لم يحدد'}',
                style: TextStyles.font14SoftBlack,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
