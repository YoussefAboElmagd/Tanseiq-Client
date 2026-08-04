import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/manager/arafat_electricity_cubit.dart';

class ImageUploadCard extends StatelessWidget {
  const ImageUploadCard({super.key, required this.cubit});
  final ArafatElectricityCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 6.h,
      children: [
        Text('صورة القراءة (اختياري)', style: TextStyles.font12NormalGrey),
        GestureDetector(
          onTap: () => cubit.emitPickImage(context),
          child: Container(
            width: double.infinity,
            height: 130.h,
            decoration: DottedDecoration(
              shape: Shape.box,
              color: ColorsManager.mainColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Container(
              margin: EdgeInsets.all(1.r),
              decoration: BoxDecoration(
                color: ColorsManager.soft2MainColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: cubit.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(cubit.image!, fit: BoxFit.cover),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8.h,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          color: ColorsManager.mainColor,
                          size: 32.r,
                        ),
                        Text(
                          'انقر لرفع صورة',
                          style: TextStyles.font14MainColor,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
