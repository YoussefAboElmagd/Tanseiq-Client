import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';
import 'package:tanseiq/features/camp/presentation/views/camp_details_bloc_listener.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_details/camp_details_tab_bar.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_details/camps_details_attributes.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_prepare_and_all_work/prepare_tint_item.dart';

class CampDetails extends StatefulWidget {
  const CampDetails({super.key, required this.campId});
  final String campId;

  @override
  State<CampDetails> createState() => _CampDetailsState();
}

class _CampDetailsState extends State<CampDetails> {
  @override
  void initState() {
    super.initState();
    CampCubit.get(context).emitGetAllCampDetails(campId: widget.campId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampCubit, CampStates>(
      builder: (context, state) {
        var cubit = CampCubit.get(context);
        if (state is GetCampDetailsLoading ||
            state is GetCampPreparingWorkLoading) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: customAppBar(context: context, title: 'تفاصيل المخيم'),
          body:
              state is GetCampDetailsError || state is GetCampPreparingWorkError
                  ? const EmptyList()
                  : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: DefaultTabController(
                        length: 1,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                spacing: 20.h,
                                children: [
                                  // CampDetailsAnalysisItem(
                                  //   tentStatistic:
                                  //       cubit.campDetails.tentStatistics,
                                  // ),
                                  CampsDetailsAttributes(
                                    campInfo: cubit.campDetails,
                                  ),
                                  // const OptimizedCampPositionMap(),
                                  // const QuantityFilterRow(),
                                ],
                              ),
                            ),
                            const SliverToBoxAdapter(
                              child: CampDetailsTabBar(),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(
                                height: 450.h,
                                child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    CustomScrollView(
                                      slivers: [
                                        SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            (BuildContext context, int index) =>
                                                cubit.prepare.isEmpty
                                                    ? EmptyList(
                                                      onRefresh: () async {
                                                        await cubit
                                                            .emitGetAllCampDetails(
                                                              campId:
                                                                  widget.campId,
                                                            );
                                                      },
                                                      image:
                                                          Assets
                                                              .assetsImagesTint,
                                                      imageColor:
                                                          ColorsManager
                                                              .mainColor,
                                                      textStyle:
                                                          TextStyles
                                                              .font16MainColorBold,
                                                    )
                                                    : PrepareTintItem(
                                                      uploadImage: () {
                                                        cubit.emitPickImage(
                                                          context: context,
                                                        );
                                                      },
                                                      save: () async {
                                                        await saveFunction(
                                                          cubit,
                                                          index,
                                                        );
                                                        cubit
                                                            .prepare[index]
                                                            .completionRateController
                                                            .clear();
                                                        cubit
                                                            .prepare[index]
                                                            .notesController
                                                            .clear();
                                                        cubit.image = null;
                                                      },
                                                      parentIndex: index,
                                                      data: cubit.prepare,
                                                    ),
                                            childCount:
                                                cubit.prepare.isEmpty
                                                    ? 1
                                                    : cubit.prepare.length,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: CampDetailsBlocListener(
                                campId: widget.campId,
                              ),
                            ),
                            // const SliverToBoxAdapter(
                            //   child: AddAndPreparingButtons(),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
        );
      },
    );
  }

  Future saveFunction(CampCubit cubit, int index) async {
    if (cubit.prepare[index].notesController.text.isNotEmpty ||
        cubit.prepare[index].completionRateController.text.isNotEmpty ||
        cubit.image != null) {
      cubit.emitUpdateCampWork(
        id: cubit.prepare[index].id!,
        notes:
            cubit.prepare[index].notesController.text == ''
                ? null
                : cubit.prepare[index].notesController.text,
        rate:
            cubit.prepare[index].completionRateController.text == ''
                ? null
                : double.parse(
                  cubit.prepare[index].completionRateController.text,
                ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar(message: 'يجب ملئ حقل واحد علي الاقل'));
    }
  }
}
