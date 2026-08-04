import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_cubit.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/electric_form.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/note_type_bottom_sheet.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/notice_photos.dart';

class NoticesDetails extends StatefulWidget {
  final Function(String?)? onNoteTypeSelected;
  final int noticeIndex; // Add this

  const NoticesDetails({
    super.key,
    this.onNoteTypeSelected,
    required this.noticeIndex, // Add this
  });

  @override
  State<NoticesDetails> createState() => _NoticesDetailsState();
}

class _NoticesDetailsState extends State<NoticesDetails> {
  String? selectedNoteType;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ElectricityHypothesesCubit>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorsManager.mainColor, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 5.h,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ملاحظة ${widget.noticeIndex + 1}',
                style: TextStyles.font12Grey,
              ),
            ],
          ),
          4.height,
          Text('نوع الملاحظة', style: TextStyles.font12Grey),
          4.height,
          InkWell(
            onTap: () async {
              final result = await showModalBottomSheet<Map<String, Object?>>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder:
                    (context) => BlocProvider.value(
                      value: cubit,
                      child: const NoteTypeSideBySideBottomSheet(),
                    ),
              );

              if (result != null) {
                final subTypeId = result['subTypeid'];
                final typeId = result['typeid'];
                final selectedValue = result['selectedValue'] as String?;

                if (selectedValue != null) {
                  setState(() {
                    selectedNoteType = selectedValue;
                  });
                  widget.onNoteTypeSelected?.call(selectedValue);
                }
                cubit.selectedSubNoteId = int.tryParse(subTypeId.toString());
                cubit.selectedNoteId = int.tryParse(typeId.toString());

                // Update at specific index
                cubit.addOrUpdateNoteAtIndex(
                  index: widget.noticeIndex,
                  noteType: cubit.selectedNoteId,
                  noteSubType: cubit.selectedSubNoteId,
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.soft3Grey),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedNoteType ?? 'اختر نوع الملاحظة',
                          style:
                              selectedNoteType != null
                                  ? TextStyles.font14Black
                                  : TextStyles.font14Grey,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: ColorsManager.mainColor,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
          5.height,
          ElectricForm(
            title: 'تفاصيل اخري',
            formHint: 'ادخل تفاصيل',
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
              return null;
            },
            onChanged: (value) {
              cubit.addOrUpdateNoteAtIndex(
                index: widget.noticeIndex,
                anotherDetails: value,
              );
            },
          ),
          5.height,
          NoticePhotos(noticeIndex: widget.noticeIndex),
          5.height,
          ElectricForm(
            title: 'رقم اقرب دورة مياة',
            formHint: '1234',
            keyboardType: TextInputType.number,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
              return null;
            },
            onChanged: (value) {
              cubit.addOrUpdateNoteAtIndex(
                index: widget.noticeIndex,
                nearestRestroomNumber: value,
              );
            },
          ),
          5.height,
          ElectricForm(
            title: 'رقم بلاغ كدانة',
            formHint: '23',
            keyboardType: TextInputType.number,
            onChanged: (value) {
              cubit.addOrUpdateNoteAtIndex(
                index: widget.noticeIndex,
                kadanasReportNumber: value,
              );
            },
          ),
        ],
      ),
    );
  }
}
