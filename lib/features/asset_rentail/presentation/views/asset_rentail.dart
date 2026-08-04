import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_cubit.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_states.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/drop_downs_selection.dart';
// import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/select_rentail_region.dart';

class AssetRentail extends StatefulWidget {
  const AssetRentail({super.key});

  @override
  State<AssetRentail> createState() => _AssetRentailState();
}

class _AssetRentailState extends State<AssetRentail> {
  @override
  void initState() {
    super.initState();
    AssetRentailCubit.get(context).emitAssetsRentailMethod();
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
          body:
              state is GetRentailCompanyErrorState ||
                      state is GetDeveloperCompanyErrorState ||
                      state is GetAllCampNumberErrorState
                  ? const EmptyList()
                  : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      child: CustomScrollView(
                        slivers: [
                          // SliverList.builder(
                          //   itemBuilder: (context, index) => GestureDetector(
                          //     behavior: HitTestBehavior.opaque,
                          //     onTap: () {
                          //       cubit.setSelectRegion(index);
                          //       cubit.developerCompanyId =
                          //           cubit.developerCompany[index].id!.toString();
                          //     },
                          //     child: SelectRentailRegion(
                          //       text: cubit.developerCompany[index].name,
                          //       index: index,
                          //       currentIndex: cubit.selectRegion,
                          //     ),
                          //   ),
                          //   itemCount: cubit.developerCompany.length,
                          // ),
                          SliverToBoxAdapter(
                            child: Column(
                              spacing: 20.h,
                              children: [
                                DropDownsSelection(cubit: cubit),
                                CustomButton(
                                  borderRadius: 12.r,
                                  color: ColorsManager.green,
                                  title: 'اختيار',
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.trackRentail,
                                      routerNavigator: true,
                                      arguments: {'campNumber': ''},
                                    );
                                  },
                                ),
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
