import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
// import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/camp_item_design.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/camp_number_filter.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/categories_camps.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/company_filter.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/empty_tints.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp/tab_bar_camps.dart';

class Camp extends StatefulWidget {
  const Camp({
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
  State<Camp> createState() => _CampState();
}

class _CampState extends State<Camp> with SingleTickerProviderStateMixin {
  final controller = ScrollController();
  late TabController tabController;
  int currentTabIndex = 0;

  @override
  void initState() {
    CampCubit.get(context).emitTintDetailsMethods();
    controller.addListener(_onScroll);
    currentTabIndex = CampCubit.get(context).currentIndexTabBar;
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: currentTabIndex,
    );
    tabController.addListener(_onTabChanged);
    super.initState();
  }

  void _onTabChanged() {
    if (tabController.indexIsChanging) {
      setState(() {
        currentTabIndex = tabController.index;
      });
      // You might need to trigger different data loading based on tab
      // CampCubit.get(context).loadDataForTab(currentTabIndex);
    }
  }

  void _onScroll() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (CampCubit.get(context).tentDetails!.hasNext) {
        CampCubit.get(context).page++;
        CampCubit.get(context).emitGetAllTentsPagination(
          zone: CampCubit.get(context).zone,
          companyId: CampCubit.get(context).companyId,
        );
      }
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onScroll);
    controller.dispose();
    tabController.removeListener(_onTabChanged);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampCubit, CampStates>(
      builder: (context, state) {
        var cubit = CampCubit.get(context);
        if (state is StatisticsLoadingState ||
            state is GetDropDownFilterLoadingState) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: customAppBar(context: context, title: 'مخيمات'),
          body:
              (state is StatisticsErrorState ||
                          state is GetDropDownFilterErrorState) &&
                      cubit.statistics == null
                  ? EmptyList(
                    onRefresh: () async {
                      await cubit.emitTintDetailsMethods();
                    },
                  )
                  : RefreshIndicator(
                    onRefresh: () async {
                      await cubit.emitTintDetailsMethods();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      child:
                          state is GetAllTentsError
                              ? const EmptyList()
                              : state is GetAllTentsLoading
                              ? circular
                              : CustomScrollView(
                                controller: controller,
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: Column(
                                      spacing: 10.h,
                                      children: [
                                        CategoriesCamps(
                                          statistics: cubit.statistics!,
                                          titles: titles,
                                        ),
                                        Divider(
                                          color: ColorsManager.soft3Grey,
                                          height: 1.h,
                                          thickness: 1.h,
                                        ),
                                        CompanyFilter(cubit: cubit),
                                        CampNumberFilter(
                                          cubit: cubit,
                                          state: state,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SliverPersistentHeader(
                                    pinned: true,
                                    delegate: _SliverTabBarDelegate(
                                      TabBarCamps(
                                        cubit: cubit,
                                        tabController: tabController,
                                      ),
                                    ),
                                  ),
                                  // Display the list based on current tab
                                  _buildCurrentTabContent(
                                    cubit,
                                    state,
                                    widget.canEdit,
                                    widget.canAdd,
                                    widget.canDelete,
                                    widget.canList,
                                    widget.isDeleted,
                                  ),
                                  if (state is GetAllTentsPaginationLoading)
                                    SliverToBoxAdapter(
                                      child: SizedBox(
                                        height: 100.h,
                                        width: 100.w,
                                        child: circular,
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

  Widget _buildCurrentTabContent(
    CampCubit cubit,
    CampStates state,
    bool? canEdit,
    bool? canAdd,
    bool? canDelete,
    bool? canList,
    bool? isDeleted,
  ) {
    // Get the appropriate data based on current tab
    // You might need to modify this based on how your tabs work
    List<dynamic> currentTents = _getTentsForCurrentTab(cubit, currentTabIndex);

    if (currentTents.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(height: 400.h, child: const EmptyTints()),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // print("canAdd $canAdd");
            // print("canEdit $canEdit");
            // print("canDelete $canDelete");
            // print("canList $canList");
            // print("isDeleted $isDeleted");
            // if (canEdit == true || canDelete == true) {
            // context.read<UiCubit>().emitCheckRoute(
            //   route: Routes.campDetails,
            //   context: context,
            //   data: {'campId': currentTents[index].id.toString()},
            // );
            print('hello');

            context.pushNamed(
              Routes.campDetails,
              arguments: {'campId': currentTents[index].id.toString()},
            );
            // }
          },
          child: CampItemDesign(data: currentTents[index]),
        ),
        childCount: currentTents.length,
      ),
    );
  }

  List<dynamic> _getTentsForCurrentTab(CampCubit cubit, int tabIndex) {
    // Modify this method based on how you filter tents for different tabs
    // For now, returning all tents - you should implement the logic based on your tabs
    switch (tabIndex) {
      case 0:
        return cubit.tentDetails?.tents ?? [];
      case 1:
        // Return filtered tents for tab 1
        return cubit.tentDetails?.tents ?? [];
      case 2:
        // Return filtered tents for tab 2
        return cubit.tentDetails?.tents ?? [];
      default:
        return cubit.tentDetails?.tents ?? [];
    }
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar);

  final Widget _tabBar;

  @override
  double get minExtent => 50.h;
  @override
  double get maxExtent => 50.h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
