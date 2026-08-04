import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar_slivers.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
// import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/manager/readiness_monitoring_cubit.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/manager/readiness_monitoring_states.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/views/widgets/comapny_analysis.dart';
// import 'package:tanseiq/features/readiness_monitoring/presentation/views/widgets/map_display_design.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/views/widgets/performance_indicators.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/views/widgets/tint_status.dart';

class ReadinessMonitoring extends StatefulWidget {
  const ReadinessMonitoring({
    super.key,
    required this.total,
    required this.compelete,
    required this.delay,
    required this.inProgress,
    required this.canAdd,
    required this.canEdit,
    required this.canDelete,
    required this.canList,
    required this.isDeleted,
  });
  final int total;
  final int compelete;
  final int delay;
  final int inProgress;
  final bool? canAdd;
  final bool? canEdit;
  final bool? canDelete;
  final bool? canList;
  final bool? isDeleted;

  @override
  State<ReadinessMonitoring> createState() => _ReadinessMonitoringState();
}

class _ReadinessMonitoringState extends State<ReadinessMonitoring> {
  @override
  void initState() {
    super.initState();
    ReadinessMonitoringCubit.get(context).emitGetCampPercentage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadinessMonitoringCubit, ReadinessMonitoringStates>(
      builder: (context, state) {
        var cubit = ReadinessMonitoringCubit.get(context);
        if (state is GetCampPercentageLoadingState) {
          return const LoadingWidget();
        }
        return Scaffold(
          body:
              state is GetCampPercentageErrorState
                  ? EmptyList(
                    onRefresh: () async {
                      await cubit.emitGetCampPercentage();
                    },
                  )
                  : RefreshIndicator(
                    onRefresh: () async {
                      await cubit.emitGetCampPercentage();
                    },
                    backgroundColor: ColorsManager.white,
                    color: ColorsManager.mainColor,
                    child: CustomScrollView(
                      slivers: [
                        const CustomAppBarSlivers(
                          displayArrow: true,
                          tilte: 'متابعة الجاهزية',
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            child: Column(
                              spacing: 30.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomButton(
                                  color: ColorsManager.green,
                                  borderRadius: 16.r,
                                  textStyle: TextStyles.font16WhiteBold,
                                  title: 'احصائيات المخيمات',
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.campAnalysis,
                                      routerNavigator: true,
                                    );
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // context.read<UiCubit>().emitCheckRoute(
                                    //   route: Routes.camps,
                                    //   context: context,
                                    //   data: {
                                    //     'canAdd': widget.canAdd!,
                                    //     'canEdit': widget.canEdit!,
                                    //     'canDelete': widget.canDelete!,
                                    //     'canList': widget.canList!,
                                    //     'isDeleted': widget.isDeleted!,
                                    //   },
                                    //   // routerNavigator: true,
                                    // );
                                    context.pushNamed(
                                      Routes.camps,
                                      arguments: {
                                        'canAdd': widget.canAdd,
                                        'canEdit': widget.canEdit,
                                        'canDelete': widget.canDelete,
                                        'canList': widget.canList,
                                        'isDeleted': widget.isDeleted,
                                      },
                                      routerNavigator: true,
                                    );
                                  },
                                  child: Performanceindicators(
                                    total: widget.total,
                                    inProgress: widget.inProgress,
                                    delay: widget.delay,
                                    compelete: widget.compelete,
                                  ),
                                ),
                                // const MapDisplayDesign(),
                                TintStatus(
                                  total: widget.total,
                                  inProgress: widget.inProgress,
                                  delay: widget.delay,
                                  compelete: widget.compelete,
                                ),
                                // const Reports(),
                                CompanyAnalysis(company: cubit.campAanalysis),
                                // const ResponseAvgerage(),
                              ],
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
