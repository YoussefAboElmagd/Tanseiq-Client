import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_analysis/camp_analysis_titles.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_analysis/classifications.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_analysis/statistics_acheivement.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_analysis/terms.dart';

class CampAnalysis extends StatelessWidget {
  const CampAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'احصائيات المخيمات'),
      body: BlocBuilder<CampCubit, CampStates>(
        builder: (context, state) {
          var cubit = CampCubit.get(context);
          return DefaultTabController(
            length: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                spacing: 10.h,
                children: [
                  SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder:
                          (context, index) => CampAnalysisTitles(
                            cubit: cubit,
                            index: index,
                            title: getTitle(index),
                          ),
                    ),
                  ),
                  Expanded(
                    child:
                        cubit.currentCampAnalysis == 0
                            ? StatisticsAcheivement(cubit: cubit, state: state)
                            : cubit.currentCampAnalysis == 1
                            ? Classifications(cubit: cubit, state: state)
                            : Terms(cubit: cubit, state: state),
                  ),

                  // CampAnalysisItemDesign(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String getTitle(int index) {
    if (index == 0) {
      return 'إحصائيات نسبة الانجاز';
    } else if (index == 1) {
      return 'إحصائيات نسبة الانجاز للتصنيفات';
    } else {
      return 'إحصائيات نسبة الانجاز للبنود';
    }
  }
}
