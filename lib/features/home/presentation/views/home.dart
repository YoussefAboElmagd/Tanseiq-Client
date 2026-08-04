import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar_slivers.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/home/presentation/manager/home_cubit.dart';
import 'package:tanseiq/features/home/presentation/manager/home_states.dart';
import 'package:tanseiq/features/home/presentation/views/widgets/readiness_monitoring_item.dart';
import 'package:tanseiq/features/home/presentation/views/widgets/reports_and_complain.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        String userType = CachHelper.getData(key: 'userType') ?? '';
        if (state is HomeStatisticsLoadingState ||
            state is HomeMainReportLoadingState) {
          return const LoadingWidget();
        }
        // print(userType);
        return Scaffold(
          key: key,
          body:
              state is HomeStatisticsErrorState ||
                      state is HomeMainReportErrorState
                  ? EmptyList(
                    text: 'يوجد مشكله في جلب البيانات',
                    onRefresh: () async {
                      await cubit.emitGetHomeStatistics();
                    },
                    imageColor: ColorsManager.darkRed,
                  )
                  : RefreshIndicator(
                    onRefresh: () async {
                      await cubit.emitGetHomeStatistics();
                    },
                    backgroundColor: ColorsManager.white,
                    color: ColorsManager.mainColor,
                    child: CustomScrollView(
                      slivers: [
                        const CustomAppBarSlivers(tilte: 'الشاشة الرئيسية'),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            child: Column(
                              spacing: 20.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                userType != 'استشاري'
                                    ? const SizedBox.shrink()
                                    : CustomButton(
                                      borderRadius: 16.r,
                                      textStyle: TextStyles.font16WhiteBold,
                                      title: 'تسجيل القراءات',
                                      onTap: () {
                                        // context.read<UiCubit>().emitCheckRoute(
                                        //   route: Routes.recordingReadings,
                                        //   context: context,
                                        // );
                                        context.pushNamed(
                                          Routes.recordingReadings,
                                        );
                                      },
                                    ),
                                CustomButton(
                                  borderRadius: 16.r,
                                  textStyle: TextStyles.font16WhiteBold,
                                  title: 'تسجيل فرضيات المياه',
                                  onTap: () {
                                    context.pushNamed(Routes.waterHypothesis);
                                  },
                                ),
                                CustomButton(
                                  borderRadius: 16.r,
                                  textStyle: TextStyles.font16WhiteBold,
                                  title: 'فرضية الكهرباء مشعر مني',
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.electricityHypotheses,
                                    );
                                  },
                                ),
                                CustomButton(
                                  borderRadius: 16.r,
                                  textStyle: TextStyles.font16WhiteBold,
                                  title: 'فرضية الكهرباء مشعر عرفه',
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.arafatElectricityReading,
                                    );
                                  },
                                ),
                                // userType != 'استشاري'
                                //     ? const SizedBox.shrink()
                                //     : CustomButton(
                                //       borderRadius: 16.r,
                                //       textStyle: TextStyles.font16WhiteBold,
                                //       title: 'رخصة الجاهزية',
                                //       onTap: () {
                                //         context.pushNamed(
                                //           Routes.readinessLicense,
                                //         );
                                //       },
                                //     ),
                                // userType != 'استشاري'
                                //     ? const SizedBox.shrink()
                                // :
                                ReadinessMonitoringItem(
                                  statistics: cubit.homeStatistics,
                                ),
                                userType != 'استشاري'
                                    ? CustomButton(
                                      borderRadius: 16.r,
                                      textStyle: TextStyles.font16WhiteBold,
                                      title: 'اضافة بلاغ جديد',
                                      onTap: () {
                                        context.pushNamed(
                                          Routes.addComplains,
                                          // arguments: {
                                          //   'markers': cubit.markers,
                                          //   'isCadana': cubit.currentIndex == 1 ? true : false,
                                          // },
                                        );
                                      },
                                    )
                                    : ReportsAndComplain(
                                      mainReport: cubit.mainReport,
                                    ),
                                // const Hypothesis(),
                                // userType != 'استشاري'
                                //     ? const SizedBox.shrink()
                                //     : const RentailFollow(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
// 