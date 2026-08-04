import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_states.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/add_complains_button.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/complains_filters.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/complains_list.dart';

class DisplayComplains extends StatefulWidget {
  const DisplayComplains({super.key, this.canAdd});
  final bool? canAdd;

  @override
  State<DisplayComplains> createState() => _DisplayComplainsState();
}

class _DisplayComplainsState extends State<DisplayComplains> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    ComplainsCubit.get(context).emitGetAllProblemsMethods();
    controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (ComplainsCubit.get(context).hasNext) {
        ComplainsCubit.get(context).page++;
        ComplainsCubit.get(context).currentIndex == 0
            ? ComplainsCubit.get(context).emitGetPaginatedProblems()
            : ComplainsCubit.get(context).emitGetPaginatedProblemCadana();
      }
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onScroll);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplainsCubit, ComplainsStates>(
      builder: (context, state) {
        var cubit = ComplainsCubit.get(context);
        if (state is GetComplainOptionTypesLoadingState ||
            state is GetProblemStatusLoadingState) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: customAppBar(context: context, title: 'البلاغات'),
          body: RefreshIndicator(
            onRefresh: () async {
              cubit.page = 0;
              cubit.currentIndex == 0
                  ? await cubit.emitGetAllProblems()
                  : await cubit.emitGetAllProblemCadana();
            },
            color: ColorsManager.mainColor,
            backgroundColor: ColorsManager.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  // SelectComplainsTypeRow(cubit: cubit),
                  15.height,
                  AddComplainsButton(cubit: cubit, canAdd: widget.canAdd),
                  15.height,
                  ComplainsFilter(cubit: cubit),
                  15.height,
                  state is GetAllComplainsLoadingState
                      ? circular
                      : state is GetAllComplainsErrorState
                      ? EmptyList(
                        text: state.errorMessage,
                        onRefresh: () async {
                          // cubit.page = 0;
                          ComplainsCubit.get(context).page = 0;
                          cubit.currentIndex == 0
                              ? await cubit.emitGetAllProblems()
                              : await cubit.emitGetAllProblemCadana();
                        },
                      )
                      : cubit.complainsData.isEmpty
                      ? EmptyList(
                        onRefresh: () async {
                          // cubit.page = 0;
                          ComplainsCubit.get(context).page = 0;
                          cubit.currentIndex == 0
                              ? await cubit.emitGetAllProblems()
                              : await cubit.emitGetAllProblemCadana();
                        },
                        image: Assets.assetsImagesTint,
                        imageColor: ColorsManager.mainColor,
                        textStyle: TextStyles.font14MainColorBold,
                      )
                      : Expanded(
                        child: ComplainsList(
                          controller: controller,
                          cubit: cubit,
                          state: state,
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
