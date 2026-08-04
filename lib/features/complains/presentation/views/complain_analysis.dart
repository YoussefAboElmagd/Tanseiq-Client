import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_states.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/camp_analysis.dart/analysis_by_status.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/camp_analysis.dart/analysis_by_status_titles.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/camp_analysis.dart/analysis_by_type.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/camp_analysis.dart/analysis_by_type_titles.dart';

class ComplainAnalysis extends StatefulWidget {
  const ComplainAnalysis({super.key});

  @override
  State<ComplainAnalysis> createState() => _ComplainAnalysisState();
}

class _ComplainAnalysisState extends State<ComplainAnalysis> {
  @override
  void initState() {
    super.initState();
    ComplainsCubit.get(context).emitComplainAnalysisMethods();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplainsCubit, ComplainsStates>(
      builder: (context, state) {
        var cubit = ComplainsCubit.get(context);
        if (state is GetComplainStatusAnalysisLoadingState ||
            state is GetComplainOtionTypesAnalysisLoadingState) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: customAppBar(context: context, title: 'احصائيات البلاغات'),
          body:
              state is GetComplainStatusAnalysisErrorState ||
                      state is GetComplainOtionTypesAnalysisErrorState
                  ? const EmptyList()
                  : SafeArea(
                    child: Column(
                      spacing: 20.h,
                      children: [
                        const AnalysisByTypeTitles(),
                        Expanded(
                          child:
                              cubit.complainOptionTypes.isEmpty
                                  ? const EmptyList()
                                  : AnalysisByType(cubit: cubit),
                        ),
                        const AnalysisByStatusTitles(),
                        Expanded(
                          child:
                              cubit.complainStatus.isEmpty
                                  ? const EmptyList()
                                  : AnalysisByStatus(cubit: cubit),
                        ),
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
