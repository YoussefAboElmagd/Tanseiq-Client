import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
// import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_states.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/complain_item_design.dart';

class ComplainsList extends StatelessWidget {
  const ComplainsList({
    super.key,
    required this.controller,
    required this.cubit,
    required this.state,
  });

  final ScrollController controller;
  final ComplainsCubit cubit;
  final ComplainsStates state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: controller,
            itemCount: cubit.complainsData.length,
            itemBuilder:
                (context, index) => GestureDetector(
                  onTap: () {
                    // context.pushNamed(
                    //   Routes.complainsDetails,
                    //   routerNavigator: true,
                    // arguments: {
                    //   'id': cubit.complainsData[index].id ?? 0,
                    //   'isCadana': cubit.currentIndex == 1,
                    // },
                    // );
                    // context.read<UiCubit>().emitCheckRoute(
                    //   route: Routes.complainsDetails,
                    //   context: context,
                    //   data: {
                    //     'id': cubit.complainsData[index].id ?? 0,
                    //     'isCadana': cubit.currentIndex == 1,
                    //   },
                    // );
                    context.pushNamed(
                      Routes.complainsDetails,
                      arguments: {
                        'id': cubit.complainsData[index].id ?? 0,
                        'isCadana': cubit.currentIndex == 1,
                      },
                    );
                  },
                  child: Row(
                    spacing: 10.w,
                    children: [
                      Expanded(
                        child: ComplainItemDesign(
                          data: cubit.complainsData[index],
                        ),
                      ),
                      cubit.complainsData[index].problemMedia == null ||
                              cubit.complainsData[index].problemMedia!.isEmpty
                          ? const SizedBox.shrink()
                          : IconButton(
                            onPressed: () {
                              context.pushNamed(
                                Routes.displayNetworkImageList,
                                arguments: {
                                  'pathes':
                                      cubit.complainsData[index].problemMedia!,
                                },
                              );
                            },
                            icon: Image.asset(
                              Assets.assetsImagesUploadFile,
                              color: ColorsManager.green,
                              width: 30.w,
                              height: 30.h,
                            ),
                          ),
                    ],
                  ),
                ),
          ),
        ),
        state is GetPaginatedComplainsLoadingState
            ? SizedBox(height: 100.h, width: 100.w, child: circular)
            : const SizedBox.shrink(),
      ],
    );
  }
}
