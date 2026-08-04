import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/features/recording_readings/presentation/manager/recording_readings_cubit.dart';

class SelectionItem extends StatelessWidget {
  const SelectionItem({super.key, required this.cubit});
  final RecordingReadingsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      children: [
        DropDownListById(
          hintTextStyle: TextStyles.font11Grey,
          iconHeight: 10.h,
          iconWidth: 10.w,
          text: 'اختيار الشركة المطورة',
          list: cubit.developerList,
          selectedValue: cubit.developerId.isEmpty ? null : cubit.developerId,
          onChanged: (value, text) {
            cubit.developerId = value!;
            cubit.page = 0;
            cubit.emitGetReadingsView();
          },
        ),
        DropDownListById(
          iconHeight: 10.h,
          iconWidth: 10.w,
          hintTextStyle: TextStyles.font11Grey,
          text: 'اختيار الشركة المؤجرة',
          list: cubit.filterList,
          selectedValue: cubit.filterId,
          onChanged: (value, text) {
            cubit.filterId = value!;
            cubit.page = 0;
            cubit.emitGetReadingsView();
          },
        ),
        // Row(
        //   spacing: 10.w,
        //   children: [
        //     Expanded(
        //       child: DropDownListById(
        //         iconHeight: 10.h,
        //         iconWidth: 10.w,
        //         hintTextStyle: TextStyles.font11Grey,
        //         text: 'اختيار المحول',
        //         list: cubit.generatorsList,
        //         selectedValue: cubit.generatorId,
        //         onChanged: (value, text) {
        //           cubit.generatorId = value!;
        //           cubit.page = 0;
        //           cubit.emitGetAllReadings();
        //         },
        //       ),
        //     ),
        //     Expanded(
        //       child: DropDownList(
        //         iconHeight: 10.h,
        //         iconWidth: 10.w,
        //         hintTextStyle: TextStyles.font11Grey,
        //         text: 'اختيار المشعر',
        //         list: const [
        //           'الكل',
        //           'عرفات',
        //           'مني',
        //         ],
        //         selectedValue: cubit.zoneId,
        //         onChanged: (value) {
        //           cubit.zoneId = value! == 'الكل'
        //               ? '0'
        //               : value == 'عرفات'
        //                   ? '1'
        //                   : '2';
        //           cubit.page = 0;
        //           cubit.emitGetAllReadings();
        //         },
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
