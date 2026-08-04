import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';

class CampDetailsBlocListener extends StatelessWidget {
  const CampDetailsBlocListener({
    super.key,
    required this.campId,
    this.fromMina,
  });
  final String campId;
  final bool? fromMina;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CampCubit, CampStates>(
      listener: (context, state) {
        var cubit = CampCubit.get(context);
        if (state is PostPreparingTentLoadingState) {
          showDialog(
            context: context,
            builder: (context) => PopScope(canPop: true, child: circular),
          );
        }
        if (state is PostPreparingTentSuccessState) {
          context.popAlert();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              color: ColorsManager.green,
              message: 'تمت الاضافة بنجاح',
            ),
          );
          fromMina != null
              ? cubit.emitGetAllCampDetailsInMina(campId: campId)
              : cubit.emitGetAllCampDetails(campId: campId);
        }
        if (state is PostPreparingTentErrorState) {
          context.popAlert();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBar(message: state.error));
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
