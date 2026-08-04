// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/surveys/data/models/get_survey_by_id_response.dart';

class DropDownListById extends FormField<String> {
  DropDownListById({
    super.key,
    required String text,
    required List<dynamic> list,
    required String? selectedValue,
    Function(String?, dynamic)? onChanged,
    super.validator,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    Color? iconColor,
    Color? borderColor,
    double? fontSize,
    double? radiusBottomLeft,
    double? radiusBottomRight,
    double? radiusTopLeft,
    double? radiusTopRight,
    double? iconWidth,
    double? iconHeight,
    bool? showDeletion,
  }) : super(
         initialValue:
             selectedValue != null && selectedValue != ''
                 ? selectedValue
                 : null,
         builder: (FormFieldState<String> state) {
           final ButtonStyleData buttonStyleData = ButtonStyleData(
             padding: const EdgeInsets.symmetric(horizontal: 15),
             decoration: BoxDecoration(
               color: ColorsManager.white,
               border: Border.all(
                 color:
                     state.hasError
                         ? ColorsManager.red
                         : borderColor ?? ColorsManager.mainColor,
               ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(radiusBottomLeft ?? 12),
                 bottomRight: Radius.circular(radiusBottomRight ?? 12),
                 topLeft: Radius.circular(radiusTopLeft ?? 12),
                 topRight: Radius.circular(radiusTopRight ?? 12),
               ),
             ),
             height: 50.h,
             width: double.infinity,
           );

           final DropdownStyleData dropdownStyleData = DropdownStyleData(
             useSafeArea: true,
             decoration: BoxDecoration(
               color: ColorsManager.white,
               borderRadius: BorderRadius.circular(16.r),
             ),
             maxHeight: 150,
           );

           const MenuItemStyleData menuItemStyleData = MenuItemStyleData(
             height: 50,
           );

           final IconStyleData iconStyleData = IconStyleData(
             icon: Image(
               image: const AssetImage(Assets.assetsImagesArrowDown),
               width: iconWidth ?? 15.w,
               height: iconHeight ?? 15.h,
               color: iconColor ?? ColorsManager.darkGrey,
             ),
           );
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               DropdownButtonHideUnderline(
                 child: DropdownButton2<String>(
                   isExpanded: true,
                   hint: Text(text, style: hintTextStyle ?? textStyle),
                   items:
                       list.map((itemData) {
                         return DropdownMenuItem<String>(
                           value: itemData.id.toString(),
                           child: Row(
                             children: [
                               Text(
                                 itemData.name,
                                 style: TextStyle(
                                   fontSize: fontSize ?? 16,
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                               const Spacer(),
                               if (selectedValue != null &&
                                   showDeletion != null)
                                 GestureDetector(
                                   onTap: () {
                                     state.didChange(null);
                                     onChanged?.call(null, null);
                                   },
                                   child: Icon(
                                     Icons.close,
                                     size: 20.r,
                                     color: ColorsManager.red,
                                   ),
                                 ),
                             ],
                           ),
                         );
                       }).toList(),
                   value: state.value,
                   onChanged: (selectedId) {
                     if (selectedId != null) {
                       dynamic selectedItem = list.firstWhere(
                         (item) => item.id.toString() == selectedId,
                       );
                       state.didChange(selectedId);
                       onChanged?.call(selectedId, selectedItem); // Pass both
                     }
                   },
                   iconStyleData: iconStyleData,
                   buttonStyleData: buttonStyleData,
                   dropdownStyleData: dropdownStyleData,
                   menuItemStyleData: menuItemStyleData,
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(left: 18.w, top: 8),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyles.font12Red,
                   ),
                 ),
             ],
           );
         },
       );
}

class StatusDropDownListById extends FormField<String> {
  StatusDropDownListById({
    super.key,
    required String text,
    required List<dynamic> list,
    required String? selectedValue,
    Function(String?)? onChanged,
    super.validator,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    Color? iconColor,
    Color? borderColor,
    double? radiusBottomLeft,
    double? radiusBottomRight,
    double? radiusTopLeft,
    double? radiusTopRight,
    double? iconWidth,
    double? iconHeight,
  }) : super(
         initialValue:
             selectedValue != null
                 ? selectedValue.isNotEmpty
                     ? selectedValue
                     : null
                 : null,
         builder: (FormFieldState<String> state) {
           final ButtonStyleData buttonStyleData = ButtonStyleData(
             padding: const EdgeInsets.symmetric(horizontal: 15),
             decoration: BoxDecoration(
               color: ColorsManager.white,
               border: Border.all(
                 color:
                     state.hasError
                         ? ColorsManager.red
                         : borderColor ?? ColorsManager.mainColor,
               ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(radiusBottomLeft ?? 12),
                 bottomRight: Radius.circular(radiusBottomRight ?? 12),
                 topLeft: Radius.circular(radiusTopLeft ?? 12),
                 topRight: Radius.circular(radiusTopRight ?? 12),
               ),
             ),
             height: 50.h,
             width: double.infinity,
           );

           final DropdownStyleData dropdownStyleData = DropdownStyleData(
             useSafeArea: true,
             decoration: BoxDecoration(
               color: ColorsManager.white,
               borderRadius: BorderRadius.circular(16.r),
             ),
             maxHeight: 150,
           );

           const MenuItemStyleData menuItemStyleData = MenuItemStyleData(
             height: 50,
           );

           final IconStyleData iconStyleData = IconStyleData(
             icon: Image(
               image: const AssetImage(Assets.assetsImagesArrowDown),
               width: iconWidth ?? 15.w,
               height: iconHeight ?? 15.h,
               color: iconColor ?? ColorsManager.darkGrey,
             ),
           );
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               DropdownButtonHideUnderline(
                 child: DropdownButton2<String>(
                   isExpanded: true,
                   hint: Text(text, style: hintTextStyle ?? textStyle),
                   items:
                       list.map((itemData) {
                         return DropdownMenuItem<String>(
                           value: itemData.id.toString(),
                           child: Padding(
                             padding: EdgeInsets.symmetric(horizontal: 10.w),
                             child: Row(
                               mainAxisAlignment:
                                   MainAxisAlignment.spaceBetween,
                               children: [
                                 CircleAvatar(
                                   radius: 5.r,
                                   backgroundColor:
                                       statusColor[list.indexOf(itemData)],
                                 ),
                                 Text(
                                   itemData.name,
                                   style: textStyle ?? TextStyles.font16Black,
                                 ),
                               ],
                             ),
                           ),
                         );
                       }).toList(),
                   value: state.value,
                   onChanged: (value) {
                     state.didChange(value);
                     onChanged?.call(value);
                   },
                   iconStyleData: iconStyleData,
                   buttonStyleData: buttonStyleData,
                   dropdownStyleData: dropdownStyleData,
                   menuItemStyleData: menuItemStyleData,
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(left: 18.w, top: 8),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyles.font12Red,
                   ),
                 ),
             ],
           );
         },
       );
}

class DropDownList extends FormField<String> {
  DropDownList({
    super.key,
    required String text,
    required List<String> list,
    required String? selectedValue,
    Function(String?)? onChanged,
    super.validator,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    Color? iconColor,
    Color? borderColor,
    // double? fontSize,
    double? radiusBottomLeft,
    double? radiusBottomRight,
    double? radiusTopLeft,
    double? radiusTopRight,
    double? iconWidth,
    double? iconHeight,
  }) : super(
         initialValue:
             selectedValue != null
                 ? selectedValue.isNotEmpty
                     ? selectedValue
                     : null
                 : null,
         builder: (FormFieldState<String> state) {
           final ButtonStyleData buttonStyleData = ButtonStyleData(
             padding: const EdgeInsets.symmetric(horizontal: 15),
             decoration: BoxDecoration(
               color: ColorsManager.white,
               border: Border.all(
                 color:
                     state.hasError
                         ? Colors.red
                         : borderColor ?? ColorsManager.mainColor,
               ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(radiusBottomLeft ?? 10),
                 bottomRight: Radius.circular(radiusBottomRight ?? 10),
                 topLeft: Radius.circular(radiusTopLeft ?? 10),
                 topRight: Radius.circular(radiusTopRight ?? 10),
               ),
             ),
             height: 50.h,
             width: double.infinity,
           );

           final DropdownStyleData dropdownStyleData = DropdownStyleData(
             useSafeArea: true,
             decoration: BoxDecoration(
               color: ColorsManager.white,
               borderRadius: BorderRadius.circular(16.r),
             ),
             maxHeight: 150,
           );

           const MenuItemStyleData menuItemStyleData = MenuItemStyleData(
             height: 50,
           );

           final IconStyleData iconStyleData = IconStyleData(
             icon: Image(
               image: const AssetImage(Assets.assetsImagesArrowDown),
               width: iconWidth ?? 15.w,
               height: iconHeight ?? 15.h,
               color: iconColor ?? ColorsManager.darkGrey,
             ),
           );

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               DropdownButtonHideUnderline(
                 child: DropdownButton2<String>(
                   isExpanded: true,
                   hint: Text(text, style: hintTextStyle ?? textStyle),
                   items:
                       list
                           .map(
                             (item) => DropdownMenuItem(
                               value: item,
                               child: Text(
                                 item,
                                 style: textStyle ?? TextStyles.font16Black,
                               ),
                             ),
                           )
                           .toList(),
                   value: state.value,
                   onChanged: (value) {
                     state.didChange(value);
                     onChanged?.call(value);
                   },
                   iconStyleData: iconStyleData,
                   buttonStyleData: buttonStyleData,
                   dropdownStyleData: dropdownStyleData,
                   menuItemStyleData: menuItemStyleData,
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(right: 15.w),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyles.font12Red,
                   ),
                 ),
             ],
           );
         },
       );
}

class DropDownListSearchId extends FormField<String> {
  DropDownListSearchId({
    super.key,
    required String text,
    required List<dynamic> list,
    required String? selectedValue,
    required TextEditingController textEditingController,
    Function(String?, dynamic)? onChanged,
    super.validator,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    Color? iconColor,
    Color? borderColor,
    double? fontSize,
    double? radiusBottomLeft,
    double? radiusBottomRight,
    double? radiusTopLeft,
    double? radiusTopRight,
    double? iconWidth,
    double? iconHeight,
  }) : super(
         initialValue:
             selectedValue != null
                 ? selectedValue.isNotEmpty
                     ? selectedValue
                     : null
                 : null,
         builder: (FormFieldState<String> state) {
           final ButtonStyleData buttonStyleData = ButtonStyleData(
             padding: const EdgeInsets.symmetric(horizontal: 15),
             decoration: BoxDecoration(
               color: ColorsManager.white,
               border: Border.all(
                 color:
                     state.hasError
                         ? ColorsManager.red
                         : borderColor ?? ColorsManager.mainColor,
               ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(radiusBottomLeft ?? 12),
                 bottomRight: Radius.circular(radiusBottomRight ?? 12),
                 topLeft: Radius.circular(radiusTopLeft ?? 12),
                 topRight: Radius.circular(radiusTopRight ?? 12),
               ),
             ),
             height: 50.h,
             width: double.infinity,
           );

           final DropdownStyleData dropdownStyleData = DropdownStyleData(
             useSafeArea: true,
             decoration: BoxDecoration(
               color: ColorsManager.white,
               borderRadius: BorderRadius.circular(16.r),
             ),
             maxHeight: 300,
           );

           const MenuItemStyleData menuItemStyleData = MenuItemStyleData(
             height: 50,
           );

           final IconStyleData iconStyleData = IconStyleData(
             icon: Image(
               image: const AssetImage(Assets.assetsImagesArrowDown),
               width: iconWidth ?? 15.w,
               height: iconHeight ?? 15.h,
               color: iconColor ?? ColorsManager.darkGrey,
             ),
           );
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               DropdownButtonHideUnderline(
                 child: DropdownButton2<String>(
                   isExpanded: true,
                   hint: Text(text, style: hintTextStyle ?? textStyle),
                   items:
                       list.map((itemData) {
                         return DropdownMenuItem<String>(
                           value: itemData.id.toString(),
                           child: Row(
                             children: [
                               Text(
                                 itemData.name,
                                 style: TextStyle(
                                   fontSize: fontSize ?? 16,
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ],
                           ),
                         );
                       }).toList(),
                   value: state.value,
                   onChanged: (selectedId) {
                     if (selectedId != null) {
                       dynamic selectedItem = list.firstWhere(
                         (item) => item.id.toString() == selectedId,
                       );
                       state.didChange(selectedId);
                       onChanged?.call(selectedId, selectedItem); // Pass both
                     }
                   },
                   iconStyleData: iconStyleData,
                   buttonStyleData: buttonStyleData,
                   dropdownStyleData: dropdownStyleData,
                   menuItemStyleData: menuItemStyleData,
                   dropdownSearchData: DropdownSearchData(
                     searchController: textEditingController,
                     searchInnerWidgetHeight: 50,
                     searchInnerWidget: Container(
                       height: 50.h,
                       padding: EdgeInsets.only(
                         top: 8.h,
                         bottom: 4.h,
                         right: 8.w,
                         left: 8.w,
                       ),
                       child: TextFormField(
                         expands: true,
                         maxLines: null,
                         controller: textEditingController,
                         decoration: InputDecoration(
                           focusedBorder: OutlineInputBorder(
                             borderSide: const BorderSide(
                               color: ColorsManager.green,
                             ),
                             borderRadius: BorderRadius.circular(8.r),
                           ),
                           enabledBorder: OutlineInputBorder(
                             borderSide: const BorderSide(
                               color: ColorsManager.soft3Grey,
                             ),
                             borderRadius: BorderRadius.circular(8.r),
                           ),
                           isDense: true,
                           contentPadding: const EdgeInsets.symmetric(
                             horizontal: 10,
                             vertical: 8,
                           ),
                           hintText: 'البحث',
                           hintStyle: hintTextStyle ?? textStyle,
                           border: OutlineInputBorder(
                             borderSide: const BorderSide(
                               color: ColorsManager.softGrey,
                             ),
                             borderRadius: BorderRadius.circular(8.r),
                           ),
                         ),
                       ),
                     ),
                     searchMatchFn: (item, searchValue) {
                       try {
                         dynamic originalItem = list.firstWhere(
                           (listItem) => listItem.id.toString() == item.value,
                         );
                         return originalItem.name
                             .toString()
                             .toLowerCase()
                             .contains(searchValue.toLowerCase());
                       } catch (e) {
                         return false;
                       }
                     },
                   ),
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(left: 18.w, top: 8),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyles.font12Red,
                   ),
                 ),
             ],
           );
         },
       );
}

class DropDownListSearch extends FormField<String> {
  DropDownListSearch({
    super.key,
    required String text,
    required List<String> list,
    required String? selectedValue,
    required TextEditingController? textEditingController,
    Function(String?)? onChanged,
    super.validator,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    Color? iconColor,
    Color? borderColor,
    double? radiusBottomLeft,
    double? radiusBottomRight,
    double? radiusTopLeft,
    double? radiusTopRight,
    double? iconWidth,
    double? iconHeight,
  }) : super(
         initialValue:
             selectedValue != null
                 ? selectedValue.isNotEmpty
                     ? selectedValue
                     : null
                 : null,
         builder: (FormFieldState<String> state) {
           final ButtonStyleData buttonStyleData = ButtonStyleData(
             padding: const EdgeInsets.symmetric(horizontal: 15),
             decoration: BoxDecoration(
               color: ColorsManager.white,
               border: Border.all(
                 color:
                     state.hasError
                         ? Colors.red
                         : borderColor ?? ColorsManager.mainColor,
               ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(radiusBottomLeft ?? 10),
                 bottomRight: Radius.circular(radiusBottomRight ?? 10),
                 topLeft: Radius.circular(radiusTopLeft ?? 10),
                 topRight: Radius.circular(radiusTopRight ?? 10),
               ),
             ),
             height: 50.h,
             width: double.infinity,
           );

           final DropdownStyleData dropdownStyleData = DropdownStyleData(
             useSafeArea: true,
             decoration: BoxDecoration(
               color: ColorsManager.white,
               borderRadius: BorderRadius.circular(16.r),
             ),
             maxHeight: 300,
           );

           const MenuItemStyleData menuItemStyleData = MenuItemStyleData(
             height: 50,
           );

           final IconStyleData iconStyleData = IconStyleData(
             icon: Image(
               image: const AssetImage(Assets.assetsImagesArrowDown),
               width: iconWidth ?? 15.w,
               height: iconHeight ?? 15.h,
               color: iconColor ?? ColorsManager.darkGrey,
             ),
           );

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               DropdownButtonHideUnderline(
                 child: DropdownButton2<String>(
                   isExpanded: true,
                   hint: Text(text, style: hintTextStyle ?? textStyle),
                   items:
                       list
                           .map(
                             (item) => DropdownMenuItem(
                               value: item,
                               child: Text(
                                 item,
                                 style: textStyle ?? TextStyles.font16Black,
                               ),
                             ),
                           )
                           .toList(),
                   value: state.value,
                   onChanged: (value) {
                     state.didChange(value);
                     onChanged?.call(value);
                   },
                   iconStyleData: iconStyleData,
                   buttonStyleData: buttonStyleData,
                   dropdownStyleData: dropdownStyleData,
                   menuItemStyleData: menuItemStyleData,
                   dropdownSearchData: DropdownSearchData(
                     searchController: textEditingController,
                     searchInnerWidgetHeight: 50,
                     searchInnerWidget: Container(
                       height: 50.h,
                       padding: EdgeInsets.only(
                         top: 8.h,
                         bottom: 4.h,
                         right: 8.w,
                         left: 8.w,
                       ),
                       child: TextFormField(
                         expands: true,
                         maxLines: null,
                         controller: textEditingController,
                         decoration: InputDecoration(
                           focusedBorder: OutlineInputBorder(
                             borderSide: const BorderSide(
                               color: ColorsManager.green,
                             ),
                             borderRadius: BorderRadius.circular(8.r),
                           ),
                           enabledBorder: OutlineInputBorder(
                             borderSide: const BorderSide(
                               color: ColorsManager.soft3Grey,
                             ),
                             borderRadius: BorderRadius.circular(8.r),
                           ),
                           isDense: true,
                           contentPadding: const EdgeInsets.symmetric(
                             horizontal: 10,
                             vertical: 8,
                           ),
                           hintText: 'البحث',
                           hintStyle: hintTextStyle ?? textStyle,
                           border: OutlineInputBorder(
                             borderSide: const BorderSide(
                               color: ColorsManager.softGrey,
                             ),
                             borderRadius: BorderRadius.circular(8.r),
                           ),
                         ),
                       ),
                     ),
                     searchMatchFn: (item, searchValue) {
                       return item.value.toString().contains(searchValue);
                     },
                   ),
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(right: 15.w),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyles.font12Red,
                   ),
                 ),
             ],
           );
         },
       );
}

class SurveyDropDownList extends FormField<String> {
  SurveyDropDownList({
    super.key,
    required String text,
    required List<FieldOption> list,
    required String? selectedValue,
    Function(String?)? onChanged,
    super.validator,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    Color? iconColor,
    Color? borderColor,
    double? fontSize,
    double? radiusBottomLeft,
    double? radiusBottomRight,
    double? radiusTopLeft,
    double? radiusTopRight,
    double? iconWidth,
    double? iconHeight,
  }) : super(
         initialValue:
             selectedValue != null
                 ? selectedValue.isNotEmpty
                     ? selectedValue
                     : null
                 : null,
         builder: (FormFieldState<String> state) {
           final ButtonStyleData buttonStyleData = ButtonStyleData(
             padding: const EdgeInsets.symmetric(horizontal: 15),
             decoration: BoxDecoration(
               color: ColorsManager.white,
               border: Border.all(
                 color:
                     state.hasError
                         ? Colors.red
                         : borderColor ?? ColorsManager.mainColor,
               ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(radiusBottomLeft ?? 12),
                 bottomRight: Radius.circular(radiusBottomRight ?? 12),
                 topLeft: Radius.circular(radiusTopLeft ?? 12),
                 topRight: Radius.circular(radiusTopRight ?? 12),
               ),
             ),
             height: 50.h,
             width: double.infinity,
           );

           final DropdownStyleData dropdownStyleData = DropdownStyleData(
             useSafeArea: true,
             decoration: BoxDecoration(
               color: ColorsManager.white,
               borderRadius: BorderRadius.circular(16.r),
             ),
             maxHeight: 150,
           );

           const MenuItemStyleData menuItemStyleData = MenuItemStyleData(
             height: 50,
           );

           final IconStyleData iconStyleData = IconStyleData(
             icon: Image(
               image: const AssetImage(Assets.assetsImagesArrowDown),
               width: iconWidth ?? 15.w,
               height: iconHeight ?? 15.h,
               color: iconColor ?? ColorsManager.darkGrey,
             ),
           );

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               DropdownButtonHideUnderline(
                 child: DropdownButton2<String>(
                   isExpanded: true,
                   hint: Text(text, style: hintTextStyle ?? textStyle),
                   items:
                       list
                           .map(
                             (item) => DropdownMenuItem(
                               value: item.name,
                               child: Text(
                                 item.name,
                                 style:
                                     textStyle ??
                                     TextStyle(fontSize: fontSize ?? 20),
                               ),
                             ),
                           )
                           .toList(),
                   value: state.value,
                   onChanged: (value) {
                     state.didChange(value);
                     onChanged?.call(value);
                   },
                   iconStyleData: iconStyleData,
                   buttonStyleData: buttonStyleData,
                   dropdownStyleData: dropdownStyleData,
                   menuItemStyleData: menuItemStyleData,
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(right: 15.w),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyles.font12Red,
                   ),
                 ),
             ],
           );
         },
       );
}
