import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';

class TabBarCamps extends StatelessWidget {
  const TabBarCamps({
    super.key,
    required this.cubit,
    required this.tabController,
  });

  final CampCubit cubit;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TabBar(
        controller: tabController,
        onTap: (value) async {
          if (value != cubit.currentIndexTabBar) {
            cubit.tentDetails!.tents.clear();
            cubit.page = 0;
            cubit.currentIndexTabBar = value;
            await cubit.emitGetAllTents(
              campNumber: cubit.campNumber,
              companyId: cubit.companyId,
              zone:
                  value == 0
                      ? null
                      : value == 1
                      ? 'منى'
                      : 'عرفات',
            );
          }
        },
        isScrollable: true,
        indicatorWeight: 4,
        tabAlignment: TabAlignment.center,
        tabs: const [
          Tab(text: 'الكل'),
          Tab(text: 'مني'),
          Tab(text: 'عرفات'),
          // Tab(
          //   text: 'المزدلفة',
          // ),
        ],
        dividerColor: ColorsManager.soft3Grey,
        labelStyle: TextStyles.font16MainColorBold,
        indicatorColor: ColorsManager.mainColor,
        unselectedLabelStyle: TextStyles.font14Grey,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }
}
