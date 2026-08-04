// Changelog:
// 2026-03-27 - Youssef Helmy
// - Added camps loading/success/error states to buildWhen for BlocBuilder
// - Added loading spinner while camps data is being fetched
// - Camp dropdown now appears only after loading completes

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar_slivers.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_cubit.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_states.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/custom_electric_dropdown.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/notices_details.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/water_bloc_listener.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/yes_no_question.dart';

class WaterHypothesis extends StatefulWidget {
  const WaterHypothesis({super.key});

  @override
  State<WaterHypothesis> createState() => _WaterHypothesisState();
}

class _WaterHypothesisState extends State<WaterHypothesis> {
  String? haveNotice;
  List<int> noticeIndices = [];
  int maxNotices = 5;

  @override
  void initState() {
    super.initState();
    ElectricityHypothesesCubit.get(context).emitWaterHypthesis();
  }

  void addNotice() {
    if (noticeIndices.length < maxNotices) {
      setState(() {
        // Add the next available index
        int nextIndex = noticeIndices.isEmpty ? 0 : noticeIndices.last + 1;
        noticeIndices.add(nextIndex);
      });
    }
  }

  void removeNotice(int index) {
    setState(() {
      noticeIndices.remove(index);
      // Remove from cubit's notesList
      final cubit = ElectricityHypothesesCubit.get(context);
      if (cubit.notesList.length > index) {
        cubit.notesList.removeAt(index);
      }
      cubit.clearImagesAtIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectricityHypothesesCubit, ElectricityHypothesesStates>(
      buildWhen:
          (previous, current) =>
              current is GetAllZonesLoadingState ||
              current is GetAllZonesErrorState ||
              current is GetAllSquaresLoadingState ||
              current is GetAllSquaresErrorState ||
              current is GetAllZonesSuccessState ||
              current is GetAllSquaresSuccessState ||
              current is GetAllCampsLoadingState ||
              current is GetAllCampsSuccessState ||
              current is GetAllCampsErrorState,
      builder: (context, state) {
        var cubit = ElectricityHypothesesCubit.get(context);

        if (state is GetAllZonesLoadingState ||
            state is GetAllSquaresLoadingState ||
            state is GetAllNoteTypesLoadingState) {
          return const LoadingWidget();
        }

        return state is GetAllZonesErrorState ||
                state is GetAllSquaresErrorState ||
                state is GetAllNoteTypesErrorState
            ? EmptyList(
              text: 'يوجد مشكله في جلب البيانات',
              onRefresh: () async {
                await cubit.emitWaterHypthesis();
              },
              imageColor: ColorsManager.darkRed,
            )
            : Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  cubit.resetAllImages();
                  cubit.kadanasReportController.clear();
                  cubit.anotherDetailsController.clear();
                  cubit.nearestRestroomController.clear();
                  cubit.selectedCampId = null;
                  cubit.selectedCampId = null;
                  cubit.selectedCampId = null;

                  cubit.notesList.clear();
                  setState(() {
                    haveNotice = 'no';
                    noticeIndices.clear();
                  });
                  await cubit.emitWaterHypthesis();
                },
                backgroundColor: ColorsManager.white,
                color: ColorsManager.mainColor,
                child: CustomScrollView(
                  slivers: [
                    const CustomAppBarSlivers(
                      tilte: 'فرضيات المياه',
                      displayArrow: true,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Form(
                          key: cubit.waterFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10.h,
                            children: [
                              const Divider(color: ColorsManager.mainColor),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'تقديم فرضيه المياه',
                                    style: TextStyles.font16BlackBold,
                                  ),
                                  Divider(
                                    color: ColorsManager.mainColor.withOpacity(
                                      0.4,
                                    ),
                                  ),
                                ],
                              ),
                              5.height,
                              CustomElectriceDropDown(
                                title: 'المشعر',
                                formHint: 'اختر',
                                list: cubit.zonesList,
                                onChanged: (value, val) {
                                  cubit.selectedZoneId = value;
                                  cubit.selectedZone = val.name;
                                  cubit.selectedCampId = null;
                                  cubit.selectedCamp = null;
                                  if (cubit.selectedZoneId != null &&
                                      cubit.selectedSquareId != null) {
                                    cubit.emitGetAllCampsByCompanyId(
                                      cubit.selectedZoneId!,
                                      cubit.selectedSquareId!,
                                    );
                                  }
                                },
                              ),
                              5.height,
                              CustomElectriceDropDown(
                                title: 'رقم المربع',
                                formHint: 'اختر',
                                list: cubit.squaresList,
                                onChanged: (value, val) {
                                  cubit.selectedSquareId = value;
                                  cubit.selectedSquare = val.name;
                                  cubit.selectedCampId = null;
                                  cubit.selectedCamp = null;
                                  if (cubit.selectedZoneId != null &&
                                      cubit.selectedSquareId != null) {
                                    cubit.emitGetAllCampsByCompanyId(
                                      cubit.selectedZoneId!,
                                      cubit.selectedSquareId!,
                                    );
                                  }
                                },
                              ),
                              if (cubit.selectedZoneId != null &&
                                  cubit.selectedSquareId != null)
                                state is GetAllCampsLoadingState
                                    ? const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                    : cubit.campsList.isNotEmpty
                                        ? Column(
                                          children: [
                                            5.height,
                                            CustomElectriceDropDown(
                                              title: 'رقم الشاخص',
                                              formHint: 'اختر',
                                              list: cubit.campsList,
                                              onChanged: (value, val) {
                                                cubit.selectedCampId = value;
                                                cubit.selectedCamp = val.name;
                                              },
                                            ),
                                          ],
                                        )
                                        : const SizedBox.shrink(),
                              5.height,
                              YesNoQuestion(
                                question: 'هل توجد ملاحظة',
                                groupValue: haveNotice,
                                onChanged: (value) {
                                  setState(() {
                                    haveNotice = value;
                                    if (value == 'yes' &&
                                        noticeIndices.isEmpty) {
                                      // Add first notice automatically
                                      noticeIndices.add(0);
                                    } else if (value == 'no') {
                                      // Clear all notices
                                      noticeIndices.clear();
                                      cubit.notesList.clear();
                                    }
                                  });
                                },
                              ),

                              // Display all notices
                              if (haveNotice == 'yes')
                                ...noticeIndices.map((index) {
                                  return Column(
                                    children: [
                                      5.height,
                                      Stack(
                                        children: [
                                          NoticesDetails(
                                            noticeIndex: index,
                                            onNoteTypeSelected: (value) {},
                                          ),
                                          if (noticeIndices.length > 1 ||
                                              index > 0)
                                            Positioned(
                                              top: 10.h,
                                              left: 10.w,
                                              child: InkWell(
                                                onTap:
                                                    () => removeNotice(index),
                                                child: Container(
                                                  padding: EdgeInsets.all(4.w),
                                                  decoration:
                                                      const BoxDecoration(
                                                        color:
                                                            ColorsManager
                                                                .darkRed,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: ColorsManager.white,
                                                    size: 16.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),

                              // Add another notice button
                              if (haveNotice == 'yes' &&
                                  noticeIndices.length < maxNotices)
                                Column(
                                  children: [
                                    5.height,
                                    InkWell(
                                      onTap: addNotice,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add_circle_outline,
                                            color: ColorsManager.green,
                                            size: 20.sp,
                                          ),
                                          5.width,
                                          Text(
                                            'اضافة ملاحظه اخري (${noticeIndices.length}/$maxNotices)',
                                            style: TextStyles.font14GreenBold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              15.height,
                              SendWaterHypo(
                                cubit: cubit,
                                haveNotice: haveNotice,
                              ),
                              15.height,
                              const WaterBlocListener(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}

class SendWaterHypo extends StatelessWidget {
  const SendWaterHypo({
    super.key,
    required this.cubit,
    required this.haveNotice,
  });

  final ElectricityHypothesesCubit cubit;
  final String? haveNotice;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectricityHypothesesCubit, ElectricityHypothesesStates>(
      builder: (context, state) {
        return CustomButton(
          title: 'ارسال',
          onTap: () {
            if (cubit.selectedCampId == null ||
                cubit.selectedZone == null ||
                cubit.selectedSquare == null ||
                haveNotice == null) {
              return;
            }

            if (haveNotice == 'yes') {
              // Validate form fields (تفاصيل اخري, رقم اقرب دورة مياة)
              if (!(cubit.waterFormKey.currentState?.validate() ?? false)) {
                return;
              }

              // Validate note type is selected for all notes
              for (int i = 0; i < cubit.notesList.length; i++) {
                if (cubit.notesList[i].noteType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('يجب اختيار نوع الملاحظة لكل ملاحظة'),
                    ),
                  );
                  return;
                }
              }
            }

            context.read<ElectricityHypothesesCubit>().emitAddWaterHypothesis(
              campId: int.tryParse(cubit.selectedCampId!) ?? 0,
              isThereIsANote: haveNotice == null ? false : haveNotice == 'yes',
              square: cubit.selectedSquare!,
              zone: cubit.selectedZone!,
              camp: cubit.selectedCamp!,
            );
          },
          borderRadius: 20.r,
          color:
              cubit.selectedCampId != null &&
                      cubit.selectedZone != null &&
                      cubit.selectedSquare != null &&
                      haveNotice != null
                  ? ColorsManager.green
                  : ColorsManager.grey,
        );
      },
    );
  }
}
