// import 'package:flutter/material.dart';
// import 'package:tanseiq/core/helpers/constant.dart';
// import 'package:tanseiq/core/helpers/extentions.dart';
// import 'package:tanseiq/core/theming/colors.dart';
// import 'package:tanseiq/core/widgets/custom_button.dart';
// import 'package:tanseiq/core/widgets/custom_form_field.dart';
// import 'package:tanseiq/features/surveys/presentation/views/widgets/attributes_description_row.dart';
// import 'package:tanseiq/features/surveys/presentation/views/widgets/attributres_drop_down_list.dart';

// class SurveyAttributes extends StatelessWidget {
//   const SurveyAttributes({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           const AttributesDescriptionRow(
//             title: 'الشركة',
//           ),
//           const AttributesDropDownList(
//             list: ['شركة2', 'شركة1'],
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'رقم المربع',
//           ),
//           const AttributesDropDownList(
//             list: ['مربع2', 'مربع1'],
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'المشعر',
//           ),
//           const AttributesDropDownList(
//             list: ['مشعر2', 'مشعر1'],
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'الفئة',
//           ),
//           const AttributesDropDownList(
//             list: ['الفئة2', 'الفئة1'],
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'عدد الحجاج',
//           ),
//           CustomFormField(
//             borderColor: ColorsManager.grey,
//             hint: '00',
//             keyboardType: TextInputType.number,
//             isHint: true,
//             validator: Constant.normalValidator(context: context),
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'مساحة الخيام',
//           ),
//           CustomFormField(
//             borderColor: ColorsManager.grey,
//             hint: '00',
//             keyboardType: TextInputType.number,
//             isHint: true,
//             validator: Constant.normalValidator(context: context),
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'القدرة الكهربائية  المطلوبة ',
//           ),
//           CustomFormField(
//             borderColor: ColorsManager.grey,
//             hint: '00',
//             keyboardType: TextInputType.number,
//             isHint: true,
//             validator: Constant.normalValidator(context: context),
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'القدرة الكهربائية  المطلوبة',
//           ),
//           CustomFormField(
//             borderColor: ColorsManager.grey,
//             hint: '00',
//             keyboardType: TextInputType.number,
//             isHint: true,
//             validator: Constant.normalValidator(context: context),
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: ' اجمالى القدرة الكهربائية  المطلوبة ',
//           ),
//           CustomFormField(
//             borderColor: ColorsManager.grey,
//             hint: '00',
//             keyboardType: TextInputType.number,
//             isHint: true,
//             validator: Constant.normalValidator(context: context),
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'القدرة الكهربائية  المتوفرة  ',
//           ),
//           CustomFormField(
//             borderColor: ColorsManager.grey,
//             hint: '00',
//             keyboardType: TextInputType.number,
//             isHint: true,
//             validator: Constant.normalValidator(context: context),
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'الوفر/العجز',
//           ),
//           CustomFormField(
//             borderColor: ColorsManager.grey,
//             hint: '00',
//             keyboardType: TextInputType.number,
//             isHint: true,
//             validator: Constant.normalValidator(context: context),
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'سعة العدادات ',
//           ),
//           CustomFormField(
//             borderColor: ColorsManager.grey,
//             hint: '00',
//             keyboardType: TextInputType.number,
//             isHint: true,
//             validator: Constant.normalValidator(context: context),
//           ),
//           10.height,
//           const AttributesDescriptionRow(
//             title: 'الملاحظة للقدرة المتوفرة',
//           ),
//           CustomFormField(
//             maxLines: 4,
//             borderColor: ColorsManager.grey,
//             hint: 'محتوي نصي',
//             keyboardType: TextInputType.text,
//             isHint: true,
//             validator: Constant.normalValidator(context: context),
//           ),
//           20.height,
// CustomButton(
//   title: 'حفظ  التعديلات',
//   onTap: () {},
// ),
//           30.height,
//         ],
//       ),
//     );
//   }
// }
