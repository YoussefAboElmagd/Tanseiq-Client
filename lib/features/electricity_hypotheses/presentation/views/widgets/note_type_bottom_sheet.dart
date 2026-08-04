import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_cubit.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_states.dart';

class NoteTypeSideBySideBottomSheet extends StatefulWidget {
  const NoteTypeSideBySideBottomSheet({super.key});

  @override
  State<NoteTypeSideBySideBottomSheet> createState() =>
      _NoteTypeSideBySideBottomSheetState();
}

class _NoteTypeSideBySideBottomSheetState
    extends State<NoteTypeSideBySideBottomSheet> {
  int? selectedNoteTypeId;
  String? selectedNoteTypeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          10.height,
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorsManager.grey,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          15.height,

          // Header
          Text('نوع الملاحظة', style: TextStyles.font16BlackBold),

          Divider(color: ColorsManager.mainColor.withOpacity(0.5)),

          // Two-column layout
          Expanded(
            child: Row(
              children: [
                // Right side - Note Types
                Expanded(child: _buildNoteTypesList()),

                // Divider
                VerticalDivider(
                  color: ColorsManager.grey.withOpacity(0.3),
                  width: 1.w,
                  thickness: 1.w,
                ),

                // Left side - Sub Types
                Expanded(child: _buildSubTypesList()),
              ],
            ),
          ),

          20.height,
        ],
      ),
    );
  }

  Widget _buildNoteTypesList() {
    return BlocBuilder<ElectricityHypothesesCubit, ElectricityHypothesesStates>(
      builder: (context, state) {
        var cubit = ElectricityHypothesesCubit.get(context);

        if (cubit.noteTypesList.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Text(
                'لا توجد أنواع ملاحظات',
                style: TextStyles.font14Grey,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          itemCount: cubit.noteTypesList.length,
          separatorBuilder:
              (context, index) => Divider(
                color: ColorsManager.grey.withOpacity(0.2),
                height: 1.h,
              ),
          itemBuilder: (context, index) {
            final noteType = cubit.noteTypesList[index];
            final isSelected = selectedNoteTypeId == noteType.id;

            return InkWell(
              onTap: () {
                if (noteType.id != null) {
                  setState(() {
                    selectedNoteTypeId = noteType.id;
                    selectedNoteTypeName = noteType.name;
                  });
                  cubit.emitGetNoteSubTypesByNoteTypeId(noteType.id!);
                  cubit.addOrUpdateNoteAtIndex(noteType: noteType.id, index: 0);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? ColorsManager.green.withOpacity(0.2)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 14.sp,
                      color:
                          isSelected
                              ? ColorsManager.mainColor
                              : ColorsManager.grey,
                    ),
                    Expanded(
                      child: Text(
                        noteType.name ?? '',
                        style: TextStyles.font14Black.copyWith(
                          color:
                              isSelected
                                  ? ColorsManager.mainColor
                                  : ColorsManager.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSubTypesList() {
    return BlocBuilder<ElectricityHypothesesCubit, ElectricityHypothesesStates>(
      builder: (context, state) {
        var cubit = ElectricityHypothesesCubit.get(context);

        if (selectedNoteTypeId == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Text(
                'اختر نوع الملاحظة أولاً',
                style: TextStyles.font14Grey,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (state is GetNoteSubTypesLoadingState) {
          return const Center(child: LoadingWidget());
        }

        if (state is GetNoteSubTypesErrorState) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 40.sp,
                    color: ColorsManager.darkRed,
                  ),
                  10.height,
                  Text(
                    'حدث خطأ',
                    style: TextStyles.font14Grey,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        if (cubit.noteSubTypesList.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Text(
                'لا توجد أنواع فرعية',
                style: TextStyles.font14Grey,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          itemCount: cubit.noteSubTypesList.length,
          separatorBuilder:
              (context, index) => Divider(
                color: ColorsManager.grey.withOpacity(0.2),
                height: 1.h,
              ),
          itemBuilder: (context, index) {
            final subType = cubit.noteSubTypesList[index];

            return InkWell(
              onTap: () {
                String selectedValue =
                    '$selectedNoteTypeName -> ${subType.name ?? ''}';
                Navigator.pop(context, {
                  'subTypeid': subType.id,
                  'typeid': cubit.selectedNoteId,
                  'selectedValue': selectedValue,
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 14.sp,
                      color: ColorsManager.grey,
                    ),
                    Expanded(
                      child: Text(
                        subType.name ?? '',
                        style: TextStyles.font14Black,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
