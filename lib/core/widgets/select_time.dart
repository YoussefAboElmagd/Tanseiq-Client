import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class SelectTime extends FormField<TimeOfDay> {
  SelectTime({
    super.key,
    TimeOfDay? initialTime,
    Function(TimeOfDay?)? onChanged,
    super.validator,
    Color? iconColor,
    Color? borderColor,
  }) : super(
         initialValue: initialTime,
         builder: (FormFieldState<TimeOfDay> state) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               GestureDetector(
                 onTap: () async {
                   final TimeOfDay? pickedTime = await showTimePicker(
                     context: state.context,
                     initialTime: state.value ?? TimeOfDay.now(),
                   );
                   if (pickedTime != null) {
                     state.didChange(pickedTime);
                     onChanged?.call(pickedTime);
                     // Force the form to validate again
                     state.validate();
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
                       Text(
                         state.value == null
                             ? '00:00'
                             : state.value!.format(state.context),
                         style:
                             state.value == null
                                 ? TextStyles.font14Grey
                                 : TextStyles.font14BlackBold,
                       ),
                       const Spacer(),
                       Image(
                         height: 15.h,
                         width: 15.w,
                         color: iconColor ?? ColorsManager.mainColor,
                         image: const AssetImage(Assets.assetsImagesCalender),
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
                     style: TextStyles.font14RedBold,
                   ),
                 ),
             ],
           );
         },
       );
}
