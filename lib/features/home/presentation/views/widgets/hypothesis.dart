import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/home/presentation/views/widgets/home_item_design.dart';
import 'package:tanseiq/features/home/presentation/views/widgets/home_row_descrip_design.dart';

class Hypothesis extends StatelessWidget {
  const Hypothesis({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeRowDescripDesign(
          title: 'الفرضيات',
          image: Assets.assetsImagesSettings,
        ),
        HomeItemDesign(
          height: 172.h,
          onTap: () {
            context.pushNamed(Routes.displayHypothesis);
          },
          widget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PieChart(
                              PieChartData(
                                centerSpaceRadius: 25.r,
                                sectionsSpace: 0,
                                startDegreeOffset: 90,
                                borderData: FlBorderData(show: true),
                                sections: [
                                  PieChartSectionData(
                                    showTitle: false,
                                    color: ColorsManager.green,
                                    value: 95,
                                    radius: 8.r,
                                  ),
                                  PieChartSectionData(
                                    showTitle: false,
                                    color: ColorsManager.soft3Grey,
                                    value: 5,
                                    radius: 8.r,
                                  ),
                                ],
                              ),
                            ),
                            Text('95%', style: TextStyles.font18GreenBold),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'فرضيات الكهرباء',
                          style: TextStyles.font18GreenBold,
                        ),
                      ),
                      Expanded(
                        child: Text('12', style: TextStyles.font18GreenBold),
                      ),
                    ],
                  ),
                ),
                10.height,
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PieChart(
                              PieChartData(
                                centerSpaceRadius: 25.r,
                                sectionsSpace: 0,
                                startDegreeOffset: 90,
                                borderData: FlBorderData(show: true),
                                sections: [
                                  PieChartSectionData(
                                    showTitle: false,
                                    color: ColorsManager.darkBlue,
                                    value: 95,
                                    radius: 8.r,
                                  ),
                                  PieChartSectionData(
                                    showTitle: false,
                                    color: ColorsManager.soft3Grey,
                                    value: 5,
                                    radius: 8.r,
                                  ),
                                ],
                              ),
                            ),
                            Text('75%', style: TextStyles.font18BlueBold),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'فرضيات الماء',
                          style: TextStyles.font18BlueBold,
                        ),
                      ),
                      Expanded(
                        child: Text('12', style: TextStyles.font18BlueBold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
