import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/camp_item_design.dart';

class CampDisplayList extends StatelessWidget {
  const CampDisplayList({
    super.key,
    required this.cubit,
    required this.state,
    this.formMina,
    required this.controller,
    this.canAdd,
    this.canEdit,
    this.canDelete,
    this.canList,
    this.isDeleted,
  });

  final CampCubit cubit;
  final CampStates state;
  final bool? formMina;
  final ScrollController controller;

  final bool? canAdd;
  final bool? canEdit;
  final bool? canDelete;
  final bool? canList;
  final bool? isDeleted;
  @override
  Widget build(BuildContext context) {
    // This widget is now only used when you need a separate scrollable list
    // For the main camp screen, the list is built directly in CustomScrollView
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: controller,
            itemCount: cubit.tentDetails!.tents.length,
            itemBuilder:
                (context, index) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    formMina != null
                        ? context.read<UiCubit>().emitCheckRoute(
                          route: Routes.campDetailsInMina,
                          context: context,
                          data: {
                            'campId':
                                cubit.tentDetails!.tents[index].id.toString(),
                          },
                        )
                        : context.read<UiCubit>().emitCheckRoute(
                          route: Routes.campDetails,
                          context: context,
                          data: {
                            'campId':
                                cubit.tentDetails!.tents[index].id.toString(),
                          },
                        );
                  },
                  child: CampItemDesign(
                    formMina: formMina,
                    data: cubit.tentDetails!.tents[index],
                  ),
                ),
          ),
        ),
        state is GetAllTentsPaginationLoading
            ? SizedBox(height: 100.h, width: 100.w, child: circular)
            : const SizedBox.shrink(),
      ],
    );
  }
}
