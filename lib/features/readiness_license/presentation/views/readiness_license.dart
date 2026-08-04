import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/custom_app_bar_slivers.dart';
import 'package:tanseiq/features/readiness_license/presentation/cubit/readiness_license_cubit.dart';
import 'package:tanseiq/features/readiness_license/presentation/cubit/readiness_license_state.dart';
import 'package:tanseiq/features/readiness_license/presentation/views/widgets/readiness_license_body.dart';

class ReadinessLicense extends StatefulWidget {
  const ReadinessLicense({super.key});

  @override
  State<ReadinessLicense> createState() => _ReadinessLicenseState();
}

class _ReadinessLicenseState extends State<ReadinessLicense> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadinessLicenseCubit, ReadinessLicenseState>(
      builder: (context, state) {
        // var cubit = ReadinessLicenseCubit.get(context);

        // if (state is GetAllZonesLoadingState ||
        //     state is GetAllSquaresLoadingState ||
        //     state is GetAllNoteTypesLoadingState) {
        //   return const LoadingWidget();
        // }

        // return state is GetAllZonesErrorState ||
        //         state is GetAllSquaresErrorState ||
        //         state is GetAllNoteTypesErrorState
        //     ? EmptyList(
        //       text: 'يوجد مشكله في جلب البيانات',
        //       onRefresh: () async {
        //         // await cubit.emitWaterHypthesis();
        //       },
        //       imageColor: ColorsManager.darkRed,
        //     )
        // :
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {},
            backgroundColor: ColorsManager.white,
            color: ColorsManager.mainColor,
            child: CustomScrollView(
              slivers: [
                const CustomAppBarSlivers(
                  tilte: 'رخصة الجاهزية',
                  displayArrow: true,
                ),
                ReadinessLicenseBody(),
              ],
            ),
          ),
        );
      },
    );
  }
}
