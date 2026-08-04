import 'package:flutter/material.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';

class AddComplainAttributes extends StatelessWidget {
  const AddComplainAttributes({
    super.key,
    required this.cubit,
    // required this.markers,
  });
  final ComplainsCubit cubit;
  // final Set<Marker> markers;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text('اختر المشعر', style: TextStyles.font14SoftBlack),
        // 5.height,
        // DropDownListById(
        //   borderColor: ColorsManager.soft2Green,
        //   iconColor: ColorsManager.green2,
        //   text: 'اختر',
        //   list: cubit.zones,
        //   selectedValue: cubit.zoneId,
        //   onChanged: (value, text) {
        //     cubit.zoneId = value!;
        //     cubit.zone = text.name;
        //     cubit.campNumbers.clear();
        //     cubit.campNumber = '';
        //     cubit.emitGetAllCampNumber(zoneId: int.parse(cubit.zoneId));
        //   },
        //   validator: Constant.dropDownListValidation(context: context),
        // ),
        cubit.campNumbers.isEmpty
            ? Text('لا يوجد مخيمات حالية', style: TextStyles.font16RedBold)
            : DropDownListSearchId(
              textEditingController: TextEditingController(),
              borderColor: ColorsManager.soft2Green,
              iconColor: ColorsManager.green2,
              hintTextStyle: TextStyles.font14Grey,
              text: 'اختر مخيم',
              list: cubit.campNumbers,
              selectedValue: cubit.campNumberId,
              onChanged: (value, text) async {
                cubit.campNumberId = value!;
                cubit.campNumber = text.name;
              },
              validator: Constant.dropDownListValidation(context: context),
            ),
        10.height,
        DropDownListById(
          borderColor: ColorsManager.soft2Green,
          iconColor: ColorsManager.green2,
          text: 'اختر نوع البلاغ',
          hintTextStyle: TextStyles.font14Grey,
          list: cubit.types,
          selectedValue: cubit.complainTypeId,
          onChanged: (value, text) {
            cubit.complainTypeId = value!;
            cubit.complainType = text.name;
            cubit.emitCheckPackage();
          },
          validator: Constant.dropDownListValidation(context: context),
        ),
        10.height,

        CustomFormField(
          hint: 'عنوان',
          borderColor: ColorsManager.soft2Green,
          controller: cubit.titleController,
          validator: Constant.normalValidator(context: context),
        ),
        10.height,

        CustomFormField(
          hint: 'وصف',
          maxLines: 5,
          controller: cubit.descriptionController,
          borderColor: ColorsManager.soft2Green,
          validator: Constant.normalValidator(context: context),
        ),

        10.height,
        CustomFormField(
          hint: 'اسم مسئول الموقع',
          borderColor: ColorsManager.soft2Green,
          controller: cubit.responsablePresonName,
          validator: Constant.normalValidator(context: context),
        ),
        10.height,
        CustomFormField(
          hint: 'هاتف مسئول الموقع',
          borderColor: ColorsManager.soft2Green,
          controller: cubit.resonsablePresonPhone,
          keyboardType: TextInputType.number,
          maxLength: 11,
          validator: Constant.normalValidator(context: context),
        ),
        10.height,
        CustomFormField(
          hint: 'اضافة رابط الموقع',
          borderColor: ColorsManager.soft2Green,
          controller: cubit.urlLocation,
          keyboardType: TextInputType.url,
          validator: (value) {},
        ),
      ],
    );
  }
}
