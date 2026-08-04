import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';

class ComplainsFilter extends StatelessWidget {
  const ComplainsFilter({super.key, required this.cubit});

  final ComplainsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Expanded(
          child: DropDownListById(
            text: 'حالة البلاغ',
            list: cubit.problemStatus,
            selectedValue: '',
            onChanged: (value, text) {
              ComplainsCubit.get(context).page = 0;
              cubit.problemStatusCode = value!;
              cubit.emitGetAllProblems();
            },
          ),
        ),
        Expanded(
          child: DropDownListById(
            text: 'نوع البلاغ',
            list: cubit.optionTypes,
            selectedValue: '',
            onChanged: (value, text) {
              ComplainsCubit.get(context).page = 0;
              cubit.problemTypeCode = value!;
              cubit.emitGetAllProblems();
            },
          ),
        ),
      ],
    );
  }
}
