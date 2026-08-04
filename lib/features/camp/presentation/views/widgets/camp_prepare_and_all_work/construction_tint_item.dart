import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_building_works_response.dart';

class ConstructionTintItem extends StatelessWidget {
  const ConstructionTintItem({
    super.key,
    this.data,
    required this.index,
    this.supply,
    this.structure,
  });
  final GetCampBuildingWorksResponse? data;
  final int index;
  final Function(bool?)? supply;
  final Function(bool?)? structure;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
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
            data?.data[index].name ?? 'adel',
            style: TextStyles.font16BlackBold,
          ),
          10.height,
          Row(
            children: [
              Checkbox(
                activeColor: ColorsManager.green,
                value: data!.data[index].supply,
                onChanged: supply,
              ),
              Text('التوريد', style: TextStyles.font14Black),
              10.width,
              Checkbox(
                activeColor: ColorsManager.green,
                value: data!.data[index].structure,
                onChanged: structure,
              ),
              Text('التركيب', style: TextStyles.font14Black),
            ],
          ),
          10.height,
          Text('الملاحظات', style: TextStyles.font14Green),
          5.height,
          CustomFormField(
            isHint: true,
            maxLines: 4,
            hint: 'نص',
            validator: (value) {},
          ),
        ],
      ),
    );
  }
}
