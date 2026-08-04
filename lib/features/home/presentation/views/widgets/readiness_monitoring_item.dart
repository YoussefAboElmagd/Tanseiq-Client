import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
// import 'package:tanseiq/core/theming/colors.dart';
// import 'package:tanseiq/core/theming/styles.dart';
// import 'package:tanseiq/core/widgets/custom_button.dart';
// import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/home/data/models/get_home_statistics_response.dart';
import 'package:tanseiq/features/home/presentation/views/widgets/home_item_design.dart';
import 'package:tanseiq/features/home/presentation/views/widgets/home_row_descrip_design.dart';
import 'package:tanseiq/features/home/presentation/views/widgets/monitoring_item_design.dart';

class ReadinessMonitoringItem extends StatelessWidget {
  const ReadinessMonitoringItem({super.key, required this.statistics});
  final GetHomeStatisticsResponse statistics;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeRowDescripDesign(
          title: 'متابعة الجاهزية',
          image: Assets.assetsImagesLucideChart,
        ),
        HomeItemDesign(
          height: 330.h,
          onTap: () {
            // context.read<UiCubit>().emitCheckRoute(
            //   route: Routes.campReadiness,
            //   context: context,
            //   data: {
            //     'compelete': statistics.completedCamps,
            //     'total': statistics.camps,
            //     'delay': statistics.delayedCamps,
            //     'inProgress': statistics.inProcessCamps,
            //   },
            // );
            context.pushNamed(
              Routes.campReadiness,
              arguments: {
                'compelete': statistics.completedCamps,
                'total': statistics.camps,
                'delay': statistics.delayedCamps,
                'inProgress': statistics.inProcessCamps,
              },
            );
          },
          widget: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Column(
              spacing: 20.h,
              children: [
                MonitoringItemDesign(
                  color: homeStatisticsColors[0],
                  image: homeStatisticsImages[0],
                  title: homeStatisticsTitles[0],
                  textStyle: homeStatisticsStyles[0],
                  quantity: statistics.completedCamps.toString(),
                ),
                MonitoringItemDesign(
                  color: homeStatisticsColors[1],
                  image: homeStatisticsImages[1],
                  title: homeStatisticsTitles[1],
                  textStyle: homeStatisticsStyles[1],
                  quantity: statistics.delayedCamps.toString(),
                ),
                MonitoringItemDesign(
                  color: homeStatisticsColors[2],
                  image: homeStatisticsImages[2],
                  title: homeStatisticsTitles[2],
                  textStyle: homeStatisticsStyles[2],
                  quantity: statistics.camps.toString(),
                ),
                MonitoringItemDesign(
                  color: homeStatisticsColors[3],
                  image: homeStatisticsImages[3],
                  title: homeStatisticsTitles[3],
                  textStyle: homeStatisticsStyles[3],
                  quantity: statistics.inProcessCamps.toString(),
                ),
                // CustomButton(
                //   borderRadius: 16.r,
                //   textStyle: TextStyles.font16WhiteBold,
                //   color: ColorsManager.green,
                //   title: 'جاهزية منى',
                //   onTap: () {
                //     context.read<UiCubit>().emitCheckRoute(
                //       route: Routes.campsInMina,
                //       context: context,
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
