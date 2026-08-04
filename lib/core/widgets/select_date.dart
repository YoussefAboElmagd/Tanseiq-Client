import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class SelectDate extends FormField<DateTime> {
  SelectDate({
    super.key,
    DateTime? initialDate,
    Function(DateTime?)? onChanged,
    super.validator,
    Color? iconColor,
    Color? borderColor,
  }) : super(
         initialValue: initialDate,
         builder: (FormFieldState<DateTime> state) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               GestureDetector(
                 onTap: () async {
                   final DateTime? pickedDate = await showDatePicker(
                     context: state.context,
                     initialDate: state.value ?? DateTime.now(),
                     firstDate: DateTime(2000),
                     lastDate: DateTime(2101),
                   );

                   if (pickedDate != null) {
                     state.didChange(pickedDate);
                     onChanged?.call(pickedDate);
                   }
                 },
                 child: Container(
                   height: 50.h,
                   width: double.infinity,
                   alignment: Alignment.centerLeft,
                   padding: EdgeInsets.symmetric(horizontal: 15.w),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10.r),
                     color: ColorsManager.white,
                     border: Border.all(
                       color:
                           state.hasError
                               ? ColorsManager.red
                               : (borderColor ?? ColorsManager.mainColor),
                     ),
                   ),
                   child: Row(
                     children: [
                       Image(
                         height: 20.h,
                         width: 20.w,
                         color: iconColor ?? ColorsManager.mainColor,
                         image: const AssetImage(Assets.assetsImagesCalender),
                       ),
                       const Spacer(),
                       Text(
                         state.value == null
                             ? 'DD/MM/YYYY'
                             : state.value!.toLocal().toString().substring(
                               0,
                               10,
                             ),
                         style:
                             state.value == null
                                 ? TextStyles.font16Grey
                                 : TextStyles.font16BlackBold,
                       ),
                     ],
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
