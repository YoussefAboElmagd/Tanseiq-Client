import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/home/data/models/main_report.dart';
import 'package:tanseiq/features/home/presentation/views/widgets/home_item_design.dart';
import 'package:tanseiq/features/home/presentation/views/widgets/home_row_descrip_design.dart';

class ReportsAndComplain extends StatelessWidget {
  const ReportsAndComplain({super.key, required this.mainReport});
  final List<MainReport> mainReport;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'تم الاصلاح':
        return ColorsManager.green;
      case 'تم الابلاغ':
        return ColorsManager.mainColor;
      case 'عدم اختصاص':
        return ColorsManager.black;
      case 'لم يتم الاصلاح':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Calculate percentages for each status type
  Map<String, double> _calculatePercentages() {
    // Initialize default values
    final percentages = {
      'fixed': 0.0,
      'reported': 0.0,
      'notSpecialized': 0.0,
      'notFixed': 0.0,
    };

    if (mainReport.isEmpty) return percentages;

    // Calculate total count
    int total = mainReport.fold(
      0,
      (sum, report) => sum + (report.totalCount ?? 0),
    );
    if (total == 0) return percentages;

    // Calculate counts for each status
    for (var report in mainReport) {
      final status = report.status ?? '';
      final count = report.totalCount ?? 0;
      final percentage = (count / total) * 100;

      switch (status) {
        case 'تم الاصلاح':
          percentages['fixed'] = percentage;
          break;
        case 'تم الابلاغ':
          percentages['reported'] = percentage;
          break;
        case 'عدم اختصاص':
          percentages['notSpecialized'] = percentage;
          break;
        case 'لم يتم الاصلاح':
          percentages['notFixed'] = percentage;
          break;
      }
    }

    return percentages;
  }

  @override
  Widget build(BuildContext context) {
    final percentages = _calculatePercentages();

    return Column(
      children: [
        const HomeRowDescripDesign(
          title: 'البلاغات',
          image: Assets.assetsImagesQuestions,
        ),
        HomeItemDesign(
          onTap: () {
            // context.read<UiCubit>().emitCheckRoute(
            //   route: Routes.displayComplains,
            //   context: context,
            // );
            context.pushNamed(Routes.displayComplains);
          },
          widget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Fixed status
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 8.r,
                            backgroundColor: ColorsManager.green,
                          ),
                          10.width,
                          Text('تم الاصلاح', style: TextStyles.font14Grey),
                        ],
                      ),
                      10.height,
                      // Reported status
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 8.r,
                            backgroundColor: ColorsManager.mainColor,
                          ),
                          10.width,
                          Text('تم الابلاغ', style: TextStyles.font14Grey),
                        ],
                      ),
                      10.height,
                      // Not specialized status
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 8.r,
                            backgroundColor: ColorsManager.black,
                          ),
                          10.width,
                          Text(
                            'عدم اختصاص',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.font14Grey,
                          ),
                        ],
                      ),
                      10.height,
                      // Not fixed status
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 8.r,
                            backgroundColor: Colors.red,
                          ),
                          10.width,
                          Text(
                            'لم يتم الاصلاح',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.font14Grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 200.w,
                    height: 200.h,
                    child: Stack(
                      children: [
                        // Fixed - Largest circle (green)
                        Positioned(
                          right: 30,
                          child: Container(
                            height: 160.h,
                            width: 160.w,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorsManager.green,
                            ),
                            child: Text(
                              '${percentages['fixed']!.toStringAsFixed(1)}%',
                              style: TextStyles.font20WhiteBold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 95.h,
                          left: 120.w,
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorsManager.black,
                            ),
                            child: Text(
                              '${percentages['notSpecialized']!.toStringAsFixed(1)}%',
                              style: TextStyles.font20WhiteBold,
                            ),
                          ),
                        ),
                        // Reported - Medium circle (main color)
                        Positioned(
                          top: 110.h,
                          left: 30.w,
                          child: Container(
                            width: 70.w,
                            height: 70.h,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorsManager.mainColor,
                            ),
                            child: Text(
                              '${percentages['reported']!.toStringAsFixed(1)}%',
                              style: TextStyles.font20WhiteBold,
                            ),
                          ),
                        ),
                        // Not fixed - Smallest circle (red)
                        Positioned(
                          top: 0.h,
                          left: 25.w,
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Text(
                              '${percentages['notFixed']!.toStringAsFixed(1)}%',
                              style: TextStyles.font12WhiteBold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
