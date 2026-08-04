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
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_cubit.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_states.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/assets_rentail_change_item.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/details/filter_row.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/details/rentail_design_item.dart';

class TrackRentail extends StatefulWidget {
  const TrackRentail({super.key});

  @override
  State<TrackRentail> createState() => _TrackRentailState();
}

class _TrackRentailState extends State<TrackRentail> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    AssetRentailCubit.get(context).emitAssetsRentailMethod();
    controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (AssetRentailCubit.get(context).hasNext) {
        AssetRentailCubit.get(context).page++;
        AssetRentailCubit.get(context).selectRequestType == 0
            ? AssetRentailCubit.get(context).emitGetPaginatedRejectedAssets()
            : AssetRentailCubit.get(context).emitGetPaginatedAllAssets();
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
    return BlocBuilder<AssetRentailCubit, AssetRentailStates>(
      builder: (context, state) {
        var cubit = AssetRentailCubit.get(context);
        if (state is GetRentailCompanyLoadingState ||
            state is GetDeveloperCompanyLoadingState ||
            state is GetAllCampNumberLoadingState) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: customAppBar(context: context, title: 'تأجير الاصول'),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                spacing: 10.h,
                children: [
                  FilterRow(cubit: cubit),
                  10.height,
                  AssetsRentailChangeItem(cubit: cubit),
                  10.height,
                  state is GetAllAssetsLoadingState ||
                          state is GetAllRejectedAssetsLoadingState
                      ? circular
                      : Expanded(
                        child:
                            (cubit.selectRequestType == 1 &&
                                        cubit.rejectedAssets.isEmpty) ||
                                    (cubit.selectRequestType == 0 &&
                                        cubit.allAssets.isEmpty)
                                ? EmptyList(
                                  imageColor: ColorsManager.green,
                                  textStyle: TextStyles.font14GreenBold,
                                  image: Assets.assetsImagesContracts,
                                )
                                : Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        controller: controller,
                                        itemCount:
                                            cubit.selectRequestType == 0
                                                ? cubit.allAssets.length
                                                : cubit.rejectedAssets.length,
                                        itemBuilder:
                                            (context, index) => GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                context.pushNamed(
                                                  Routes
                                                      .acceptedAndRejectedRequest,
                                                  arguments: {
                                                    'isRejected':
                                                        cubit.selectRequestType ==
                                                                0
                                                            ? true
                                                            : false,
                                                  },
                                                );
                                              },
                                              child: RentailItemDesign(
                                                data:
                                                    cubit.selectRequestType == 0
                                                        ? cubit.allAssets[index]
                                                        : cubit
                                                            .rejectedAssets[index],
                                                isRejected:
                                                    cubit.selectRequestType == 0
                                                        ? false
                                                        : true,
                                              ),
                                            ),
                                      ),
                                    ),
                                    state is GetAllAssetsPaginatedLoadingState ||
                                            state
                                                is GetAllRejectedAssetsPaginatedLoadingState
                                        ? SizedBox(
                                          height: 90.h,
                                          width: 90.w,
                                          child: circular,
                                        )
                                        : const SizedBox.shrink(),
                                  ],
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
