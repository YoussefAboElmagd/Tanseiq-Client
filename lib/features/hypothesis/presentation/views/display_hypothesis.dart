import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/hypothesis/presentation/manager/hypothesis_cubit.dart';
import 'package:tanseiq/features/hypothesis/presentation/manager/hypothesis_states.dart';
import 'package:tanseiq/features/hypothesis/presentation/views/widgets/hypothesis_kinds_row.dart';

class DisplayHypothesis extends StatefulWidget {
  const DisplayHypothesis({super.key});

  @override
  State<DisplayHypothesis> createState() => _DisplayHypothesisState();
}

class _DisplayHypothesisState extends State<DisplayHypothesis> {
  @override
  @override
  void initState() {
    super.initState();
    HypothesisCubit.get(context).emitGetReadingsView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HypothesisCubit, HypothesisStates>(
      builder: (context, state) {
        var cubit = HypothesisCubit.get(context);
        if (state is GetGeneratorsReadingLoadingState) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: customAppBar(context: context, title: 'متابعة الفرضيات'),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                spacing: 20.h,
                children: [
                  const Divider(color: ColorsManager.mainColor),
                  const HypothesisKindsRow(),
                  // HypothesisChangeItem(cubit: cubit),
                  Container(
                    alignment: Alignment.center,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.mainColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'فرضيات الكهرباء',
                      style: TextStyles.font14WhiteBold,
                    ),
                  ),
                  Expanded(
                    child:
                        cubit.readingsList.isEmpty
                            ? EmptyList(
                              text: 'لا يوجد فرضيات في الوفت الحالي',
                              image: Assets.assetsImagesSurveys,
                              imageColor: ColorsManager.green,
                              textStyle: TextStyles.font14Green,
                            )
                            : ListView.builder(
                              itemCount: cubit.readingsList.length,
                              itemBuilder:
                                  (context, index) => GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                        Routes.hypothesisDetails,
                                      );
                                    },
                                    // child: HypothesisItemDesign(
                                    //   title: 'كهرباء',
                                    //   data: cubit.readingsList[index],
                                    // ),
                                    child: const Text('كهرباء'),
                                  ),
                            ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
