import 'dart:io';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_cubit.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_states.dart';

class AirConditionersStatusPhotos extends StatelessWidget {
  const AirConditionersStatusPhotos({
    super.key,
    this.onTap,
    required this.deviceType,
  });

  final void Function()? onTap;
  final String deviceType;

  List<String> _getImages(ElectricityHypothesesCubit cubit) {
    return cubit.deviceImages[deviceType] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ElectricityHypothesesCubit.get(context);

    return BlocBuilder<ElectricityHypothesesCubit, ElectricityHypothesesStates>(
      builder: (context, state) {
        final images = _getImages(cubit);
        final canAddMore = images.length < 4; // Maximum 4 images

        return Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          verticalDirection: VerticalDirection.up,
          children: [
            // مربع إضافة الصور - يظهر فقط إذا كان عدد الصور أقل من 4
            if (canAddMore)
              InkWell(
                onTap: onTap,
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: DottedDecoration(
                    shape: Shape.box,
                    color: ColorsManager.mainColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: ColorsManager.soft3Grey,
                    ),
                    margin: const EdgeInsets.all(1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 30.w,
                          color: ColorsManager.grey,
                        ),
                        4.height,
                        Text(
                          'إضافة صور\n(${images.length}/4)',
                          style: TextStyles.font12NormalGrey,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // عرض الصور المختارة
            ...images.asMap().entries.map((entry) {
              final index = entry.key;
              final imagePath = entry.value;

              return Stack(
                children: [
                  Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: ColorsManager.mainColor,
                        width: 1.5.w,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: Image.file(File(imagePath), fit: BoxFit.cover),
                    ),
                  ),

                  // زر الحذف
                  Positioned(
                    top: -5.h,
                    right: -5.w,
                    child: InkWell(
                      onTap: () {
                        cubit.removeElectricImage(deviceType, index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: const BoxDecoration(
                          color: ColorsManager.darkRed,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.close,
                          color: ColorsManager.white,
                          size: 16.w,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        );
      },
    );
  }
}
