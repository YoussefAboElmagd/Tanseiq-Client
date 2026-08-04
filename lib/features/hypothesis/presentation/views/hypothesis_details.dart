import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/features/hypothesis/presentation/manager/hypothesis_cubit.dart';
import 'package:tanseiq/features/hypothesis/presentation/manager/hypothesis_states.dart';
import 'package:tanseiq/features/hypothesis/presentation/views/widgets/hypothesis_details/hypothesis_details_title_row.dart';
import 'package:tanseiq/features/hypothesis/presentation/views/widgets/hypothesis_details/load_measurement_item_design.dart';
import 'package:tanseiq/features/hypothesis/presentation/views/widgets/hypothesis_item_design.dart';

class HypothesisDetails extends StatefulWidget {
  const HypothesisDetails({super.key});

  @override
  State<HypothesisDetails> createState() => _HypothesisDetailsState();
}

class _HypothesisDetailsState extends State<HypothesisDetails> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    HypothesisCubit.get(context).emitGetGeneratorsSerials();
    controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (HypothesisCubit.get(context).hasNext) {
        HypothesisCubit.get(context).page++;
        HypothesisCubit.get(context).emitGetPaginatedComplains();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'قياس الاحمال للمحولات'),
      body: BlocBuilder<HypothesisCubit, HypothesisStates>(
        builder: (context, state) {
          var cubit = HypothesisCubit.get(context);
          if (state is GetGeneratorsSerialsLoadingState ||
              state is SaveReadingLoadingState) {
            return circular;
          }
          return SafeArea(
            child:
                state is GetGeneratorsSerialsErrorState
                    ? const EmptyList()
                    : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        spacing: 20.h,
                        children: [
                          const HypothesisDetailsTitleRow(),
                          const FiltetRow(),
                          SizedBox(
                            height: 120.h,
                            child: GridView.builder(
                              itemCount: 4,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 4,
                                  ),
                              itemBuilder:
                                  (context, index) =>
                                      LoadMeasurementItemDesign(index: index),
                            ),
                          ),
                          Expanded(
                            child:
                                cubit.generatorsList.isEmpty
                                    ? const EmptyList()
                                    : Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            controller: controller,
                                            itemBuilder:
                                                (
                                                  context,
                                                  index,
                                                ) => GestureDetector(
                                                  onTap: () {
                                                    // showDialog(
                                                    //   context: context,
                                                    //   builder: (context) => Dialog(
                                                    //     child: CreateHypothesisAlert(
                                                    //       data: cubit
                                                    //           .generatorsList[index],
                                                    //       cubit: cubit,
                                                    //     ),
                                                    //   ),
                                                    // );
                                                  },
                                                  child: HypothesisItemDesign(
                                                    title:
                                                        'المحول ${cubit.generatorsList[index].name ?? 'غير محدد'}',
                                                  ),
                                                ),
                                            itemCount:
                                                cubit.generatorsList.length,
                                          ),
                                        ),
                                        state
                                                is GetGeneratorsSerialsPaginationLoadingState
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
    );
  }
}
