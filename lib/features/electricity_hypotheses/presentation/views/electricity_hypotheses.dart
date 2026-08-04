import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar_slivers.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/models/add_electric_hypothesis_request.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_cubit.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_states.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/custom_electric_dropdown.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/electric_device_section.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/electric_form.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/water_bloc_listener.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/widgets/yes_no_question.dart';

class ElectricityHypotheses extends StatefulWidget {
  const ElectricityHypotheses({super.key});

  @override
  State<ElectricityHypotheses> createState() => _ElectricityHypothesesState();
}

class _ElectricityHypothesesState extends State<ElectricityHypotheses> {
  static const Map<String, String> _deviceLabels = {
    'waterPumps': 'هل تم تشغيل جميع غلايات المياه؟',
    'lamps': 'هل تم تشغيل جميع الثلاجات؟',
    'lighting': 'هل تم تشغيل جميع الإنارة؟',
    'airConditioners': 'هل تم تشغيل جميع المكيفات؟',
    'electricOvens': 'هل تم تشغيل جميع الأفران الكهربائية؟',
    'fans': 'هل تم تشغيل جميع المراوح؟',
    'freezers': 'هل تم تشغيل جميع الفريزرات؟',
    'plugs': 'هل تم تشغيل جميع الأفياش؟',
  };

  late Map<String, String?> _deviceStatus;
  String? _powerStatus;

  @override
  void initState() {
    super.initState();
    _deviceStatus = {
      for (final k in ElectricityHypothesesCubit.kDeviceKeys)
        k: 'notApplicable',
    };
    ElectricityHypothesesCubit.get(context).emitElectricHypothesis();
  }

  bool get _showDevices => _powerStatus == 'yes' || _powerStatus == 'partial';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectricityHypothesesCubit, ElectricityHypothesesStates>(
      buildWhen:
          (_, current) =>
              current is GetElectricZonesLoadingState ||
              current is GetElectricZonesSuccessState ||
              current is GetElectricZonesErrorState ||
              current is GetElectricSquaresLoadingState ||
              current is GetElectricSquaresSuccessState ||
              current is GetElectricSquaresErrorState ||
              current is GetElectricCampsLoadingState ||
              current is GetElectricCampsSuccessState ||
              current is GetElectricCampsErrorState,
      builder: (context, state) {
        final cubit = ElectricityHypothesesCubit.get(context);

        if (state is GetElectricZonesLoadingState ||
            state is GetElectricSquaresLoadingState) {
          return const LoadingWidget();
        }

        if (state is GetElectricZonesErrorState ||
            state is GetElectricSquaresErrorState) {
          return EmptyList(
            text: 'يوجد مشكله في جلب البيانات',
            onRefresh: () async => cubit.emitElectricHypothesis(),
            imageColor: ColorsManager.darkRed,
          );
        }

        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              cubit.selectedElectricSquare = null;
              cubit.selectedElectricCampId = null;
              cubit.selectedElectricCampName = null;
              setState(() {
                _powerStatus = null;
                _deviceStatus = {
                  for (final k in ElectricityHypothesesCubit.kDeviceKeys)
                    k: 'notApplicable',
                };
              });
              await cubit.emitElectricHypothesis();
            },
            backgroundColor: ColorsManager.white,
            color: ColorsManager.mainColor,
            child: CustomScrollView(
              slivers: [
                const CustomAppBarSlivers(
                  tilte: 'فرضية الكهرباء مشعر مني',
                  displayArrow: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: cubit.electricFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.h,
                        children: [
                          const Divider(color: ColorsManager.mainColor),

                          // Zone chip – fixed to منى
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: ColorsManager.softMainColor,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: ColorsManager.mainColor,
                                width: 1.w,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: ColorsManager.mainColor,
                                  size: 18.r,
                                ),
                                6.width,
                                Text(
                                  'المشعر: منى',
                                  style: TextStyles.font14BlackBold,
                                ),
                              ],
                            ),
                          ),

                          // Square dropdown (optional)
                          CustomElectriceDropDown(
                            title: 'رقم المربع',
                            formHint: 'اختر (اختياري)',
                            list: cubit.electricSquaresList,
                            selectedValue: cubit.selectedElectricSquare,
                            onChanged: (value, _) {
                              setState(() {
                                cubit.selectedElectricSquare = value;
                                cubit.selectedElectricCampId = null;
                                cubit.selectedElectricCampName = null;
                              });
                              cubit.emitGetElectricCampsByCompanyId(value);
                            },
                          ),

                          // Camp dropdown (required)
                          BlocBuilder<ElectricityHypothesesCubit,
                              ElectricityHypothesesStates>(
                            buildWhen:
                                (_, s) =>
                                    s is GetElectricCampsLoadingState ||
                                    s is GetElectricCampsSuccessState ||
                                    s is GetElectricCampsErrorState,
                            builder: (context, campsState) {
                              if (campsState is GetElectricCampsLoadingState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'رقم الشاخص *',
                                      style: TextStyles.font14Grey,
                                    ),
                                    10.height,
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12.h,
                                        ),
                                        child: SizedBox(
                                          width: 24.r,
                                          height: 24.r,
                                          child: const CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: ColorsManager.mainColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return CustomElectriceDropDown(
                                title: 'رقم الشاخص *',
                                formHint: 'اختر',
                                list: cubit.electricCampsList,
                                selectedValue: cubit.selectedElectricCampId,
                                onChanged: (value, val) {
                                  setState(() {
                                    cubit.selectedElectricCampId = value;
                                    cubit.selectedElectricCampName = val?.name;
                                  });
                                },
                              );
                            },
                          ),

                          const Divider(color: ColorsManager.mainColor),

                          // Power status question
                          YesNoQuestion(
                            question: 'هل التيار الكهربائي يعمل؟',
                            groupValue: _powerStatus,
                            thirdOptionValue: 'partial',
                            thirdOptionLabel: 'جزئي',
                            onChanged: (v) => setState(() => _powerStatus = v),
                          ),

                          // Kadana card (visible once power question answered)
                          if (_powerStatus != null)
                            _KadanaCard(
                              cubit: cubit,
                              powerStatus: _powerStatus!,
                            ),

                          // Warning banner + 8 device sections (only when نعم/جزئي)
                          if (_showDevices) ...[
                            _WarningBanner(),
                            ...ElectricityHypothesesCubit.kDeviceKeys.map(
                              (key) => ElectricDeviceSection(
                                label: _deviceLabels[key]!,
                                deviceKey: key,
                                status: _deviceStatus[key],
                                onChanged:
                                    (v) =>
                                        setState(() => _deviceStatus[key] = v),
                                cubit: cubit,
                              ),
                            ),
                          ],

                          15.height,
                          const WaterBlocListener(),
                          _SendElectricHypo(
                            cubit: cubit,
                            powerStatus: _powerStatus,
                            deviceStatus: _deviceStatus,
                          ),
                          15.height,
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

// ─── Kadana Card ──────────────────────────────────────────────────────────────

class _KadanaCard extends StatelessWidget {
  const _KadanaCard({required this.cubit, required this.powerStatus});

  final ElectricityHypothesesCubit cubit;
  final String powerStatus;

  @override
  Widget build(BuildContext context) {
    final isRequired = powerStatus == 'no';
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: isRequired ? ColorsManager.softRed : ColorsManager.softMainColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ElectricForm(
        title: isRequired ? 'رقم الكدانة (مطلوب)' : 'رقم الكدانة (اختياري)',
        formHint: 'أدخل رقم الكدانة',
        controller: cubit.kedanaProblemController,
        keyboardType: TextInputType.number,
        validator:
            isRequired ? Constant.normalValidator(context: context) : null,
      ),
    );
  }
}

// ─── Warning Banner ───────────────────────────────────────────────────────────

class _WarningBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.softRed,
        borderRadius: BorderRadius.circular(8.r),
        border: Border(
          right: BorderSide(color: ColorsManager.darkRed, width: 4.w),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: ColorsManager.darkRed,
            size: 20.r,
          ),
          8.width,
          Expanded(
            child: Text(
              'يرجى تعبئة بيانات جميع الأجهزة الكهربائية',
              style: TextStyles.font12NormalGrey.copyWith(
                color: ColorsManager.darkRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Send Button ──────────────────────────────────────────────────────────────

class _SendElectricHypo extends StatelessWidget {
  const _SendElectricHypo({
    required this.cubit,
    required this.powerStatus,
    required this.deviceStatus,
  });

  final ElectricityHypothesesCubit cubit;
  final String? powerStatus;
  final Map<String, String?> deviceStatus;

  bool? _getIsAll(String? status) {
    if (status == 'yes') return true;
    if (status == 'no') return false;
    return null;
  }

  AddElectricHypothesisRequest _buildRequest() {
    return AddElectricHypothesisRequest(
      squareId: int.tryParse(cubit.selectedElectricSquare ?? ''),
      campId: int.tryParse(cubit.selectedElectricCampId ?? ''),
      isPowerOutage: powerStatus == 'no',
      kedanaProblemNumber:
          cubit.kedanaProblemController.text.isNotEmpty
              ? cubit.kedanaProblemController.text
              : null,
      isAllWaterBoilersOn: _getIsAll(deviceStatus['waterPumps']),
      runningBoilerCount: int.tryParse(
        cubit.runningCtrl['waterPumps']?.text ?? '',
      ),
      totalBoilerCount: int.tryParse(cubit.totalCtrl['waterPumps']?.text ?? ''),
      boilerDetails: cubit.detailsCtrl['waterPumps']?.text,
      boilerkadanasReportNumber: cubit.kadanaCtrl['waterPumps']?.text,
      isAllRefrigeratorsOn: _getIsAll(deviceStatus['lamps']),
      runningFridgeCount: int.tryParse(cubit.runningCtrl['lamps']?.text ?? ''),
      totalFridgeCount: int.tryParse(cubit.totalCtrl['lamps']?.text ?? ''),
      fridgeDetails: cubit.detailsCtrl['lamps']?.text,
      fridgekadanasReportNumber: cubit.kadanaCtrl['lamps']?.text,
      isAllLightingOn: _getIsAll(deviceStatus['lighting']),
      runningLightingCount: int.tryParse(
        cubit.runningCtrl['lighting']?.text ?? '',
      ),
      totalLightingCount: int.tryParse(cubit.totalCtrl['lighting']?.text ?? ''),
      lightingDetails: cubit.detailsCtrl['lighting']?.text,
      lightingkadanasReportNumber: cubit.kadanaCtrl['lighting']?.text,
      isAllAirConditionersOn: _getIsAll(deviceStatus['airConditioners']),
      runningAirConditionerCount: int.tryParse(
        cubit.runningCtrl['airConditioners']?.text ?? '',
      ),
      totalAirConditionerCount: int.tryParse(
        cubit.totalCtrl['airConditioners']?.text ?? '',
      ),
      airConditionerDetails: cubit.detailsCtrl['airConditioners']?.text,
      airConditionerkadanasReportNumber:
          cubit.kadanaCtrl['airConditioners']?.text,
      isAllElectricOvensOn: _getIsAll(deviceStatus['electricOvens']),
      runningElectricOvenCount: int.tryParse(
        cubit.runningCtrl['electricOvens']?.text ?? '',
      ),
      totalElectricOvenCount: int.tryParse(
        cubit.totalCtrl['electricOvens']?.text ?? '',
      ),
      electricOvenDetails: cubit.detailsCtrl['electricOvens']?.text,
      electricOvenkadanasReportNumber: cubit.kadanaCtrl['electricOvens']?.text,
      isFansOn: _getIsAll(deviceStatus['fans']),
      runningFansCount: int.tryParse(cubit.runningCtrl['fans']?.text ?? ''),
      totalFansCount: int.tryParse(cubit.totalCtrl['fans']?.text ?? ''),
      fansDetails: cubit.detailsCtrl['fans']?.text,
      fansKadanasReportNumber: cubit.kadanaCtrl['fans']?.text,
      isFreezersOn: _getIsAll(deviceStatus['freezers']),
      runningFreezersCount: int.tryParse(
        cubit.runningCtrl['freezers']?.text ?? '',
      ),
      totalFreezersCount: int.tryParse(cubit.totalCtrl['freezers']?.text ?? ''),
      freezersDetails: cubit.detailsCtrl['freezers']?.text,
      freezersKadanasReportNumber: cubit.kadanaCtrl['freezers']?.text,
      isPlugsOn: _getIsAll(deviceStatus['plugs']),
      runningPlugsCount: int.tryParse(cubit.runningCtrl['plugs']?.text ?? ''),
      totalPlugsCount: int.tryParse(cubit.totalCtrl['plugs']?.text ?? ''),
      plugsDetails: cubit.detailsCtrl['plugs']?.text,
      plugsKadanasReportNumber: cubit.kadanaCtrl['plugs']?.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectricityHypothesesCubit, ElectricityHypothesesStates>(
      builder: (context, state) {
        final isFormValid =
            cubit.selectedElectricCampId != null && powerStatus != null;
        return CustomButton(
          title: 'ارسال',
          borderRadius: 20.r,
          color: isFormValid ? ColorsManager.green : ColorsManager.grey,
          onTap:
              isFormValid
                  ? () async {
                    if (cubit.electricFormKey.currentState!.validate()) {
                      await cubit.emitAddElectricHypothesis(_buildRequest());
                    }
                  }
                  : () {},
        );
      },
    );
  }
}
