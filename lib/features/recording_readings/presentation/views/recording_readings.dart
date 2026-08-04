import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/features/hypothesis/presentation/views/widgets/hypothesis_details/create_hypothesis_alert.dart';
import 'package:tanseiq/features/recording_readings/presentation/manager/recording_readings_cubit.dart';
import 'package:tanseiq/features/recording_readings/presentation/manager/recording_readings_states.dart';
import 'package:tanseiq/features/recording_readings/presentation/views/widget/selection_item.dart';
import 'package:tanseiq/features/recording_readings/presentation/views/widget/transformations_item_design.dart';

class RecordingReadings extends StatefulWidget {
  const RecordingReadings({super.key});

  @override
  State<RecordingReadings> createState() => _RecordingReadingsState();
}

class _RecordingReadingsState extends State<RecordingReadings> {
  // final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    RecordingReadingsCubit.get(context).emitGetGeneratorsMethods();
    // controller.addListener(_onScroll);
  }

  // void _onScroll() {
  //   if (controller.position.pixels == controller.position.maxScrollExtent) {
  //     if (RecordingReadingsCubit.get(context).hasNext) {
  //       RecordingReadingsCubit.get(context).page++;
  //       RecordingReadingsCubit.get(context).emitGetAllReadingsPagination();
  //     }
  //   }
  // }

  // @override
  // void dispose() {
  //   controller.removeListener(_onScroll);
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'قياس الاحمال للمحولات'),
      body: BlocBuilder<RecordingReadingsCubit, RecordingReadingsStates>(
        builder: (context, state) {
          var cubit = RecordingReadingsCubit.get(context);
          if (state is GetZonesLoadingState ||
              state is GetGeneratorsSerialsLoadingState ||
              state is GetDeveloperCompanyLoadingState ||
              state is GetDropDownFilterLoadingState) {
            return circular;
          }
          return state is GetZonesErrorState ||
                  state is GetGeneratorsSerialsErrorState ||
                  state is GetDeveloperCompanyErrorState ||
                  state is GetAllGeneratorsErrorState ||
                  state is GetDropDownFilterErrorState
              ? const EmptyList()
              : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: RefreshIndicator(
                  color: ColorsManager.mainColor,
                  backgroundColor: ColorsManager.white,
                  onRefresh: () async {
                    await cubit.emitGetAllReadings();
                  },
                  child: Column(
                    spacing: 20.h,
                    children: [
                      // ReadingsMapDisplay(cubit: cubit, state: state),
                      SelectionItem(cubit: cubit),
                      Expanded(
                        child:
                            state is GetGeneratorsReadingLoadingState
                                ? circular
                                : cubit.readingsList.isEmpty
                                ? EmptyList(
                                  imageColor: ColorsManager.green,
                                  image: Assets.assetsImagesTint,
                                  textStyle: TextStyles.font14GreenBold,
                                  onRefresh: () async {
                                    cubit.clearAll();
                                    await cubit.emitGetGeneratorsMethods();
                                  },
                                )
                                : Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: cubit.readingsList.length,
                                        itemBuilder:
                                            (context, index) => GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => Dialog(
                                                        child: CreateHypothesisAlert(
                                                          data:
                                                              cubit
                                                                  .readingsList[index],
                                                          cubit: cubit,
                                                        ),
                                                      ),
                                                );
                                              },
                                              child: TransformationsItemDesign(
                                                data: cubit.readingsList[index],
                                              ),
                                            ),
                                      ),
                                    ),
                                    state
                                            is GetAllGeneratorsPaginationLoadingState
                                        ? SizedBox(
                                          height: 100.h,
                                          width: 100.w,
                                          child: circular,
                                        )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                      ),
                    ],
                  ),
                ),
              );
        },
      ),
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      //   child: CustomButton(
      //     title: 'تسجيل القراءة',
      //     color: ColorsManager.green,
      //     textStyle: TextStyles.font16WhiteBold,
      //     borderRadius: 12.r,
      //     onTap: () {
      //       context.pushNamed(Routes.hypothesisDetails);
      //     },
      //   ),
      // ),
    );
  }
}
