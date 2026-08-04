import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/cam_display_list.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/camp_number_filter.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/company_filter.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/empty_tints.dart';

class CampInMina extends StatefulWidget {
  const CampInMina({
    super.key,
    this.canAdd,
    this.canEdit,
    this.canDelete,
    this.canList,
    this.isDeleted,
  });

  final bool? canAdd;
  final bool? canEdit;
  final bool? canDelete;
  final bool? canList;
  final bool? isDeleted;
  @override
  State<CampInMina> createState() => _CampInMinaState();
}

class _CampInMinaState extends State<CampInMina> {
  final controller = ScrollController();

  @override
  void initState() {
    CampCubit.get(context).emitTintDetailsInMinaMethods();
    controller.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (CampCubit.get(context).tentDetails!.hasNext) {
        CampCubit.get(context).page++;
        CampCubit.get(context).emitGetAllTentsPagination(
          zone: 'منى',
          companyId: CampCubit.get(context).companyId,
        );
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
    return BlocBuilder<CampCubit, CampStates>(
      builder: (context, state) {
        var cubit = CampCubit.get(context);
        if (state is GetDropDownFilterLoadingState) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: customAppBar(context: context, title: 'مخيمات'),
          body:
              (state is StatisticsErrorState ||
                      state is GetDropDownFilterErrorState)
                  ? EmptyList(
                    onRefresh: () async {
                      await cubit.emitTintDetailsInMinaMethods();
                    },
                  )
                  : RefreshIndicator(
                    color: ColorsManager.white,
                    backgroundColor: ColorsManager.green,
                    onRefresh: () async {
                      await cubit.emitTintDetailsInMinaMethods();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      child: DefaultTabController(
                        initialIndex: cubit.currentIndexTabBar,
                        length: 3,
                        child: Column(
                          spacing: 10.h,
                          children: [
                            CompanyFilter(customZone: 'منى', cubit: cubit),
                            CampNumberFilter(cubit: cubit, state: state),
                            state is GetAllTentsError
                                ? const EmptyList()
                                : Expanded(
                                  child:
                                      state is GetAllTentsLoading
                                          ? circular
                                          : cubit.tentDetails!.tents.isEmpty
                                          ? const EmptyTints()
                                          : CampDisplayList(
                                            isDeleted: widget.isDeleted,
                                            canAdd: widget.canAdd,
                                            canEdit: widget.canEdit,
                                            canDelete: widget.canDelete,
                                            canList: widget.canList,
                                            formMina: true,
                                            state: state,
                                            controller: controller,
                                            cubit: cubit,
                                          ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
        );
      },
    );
  }
}
