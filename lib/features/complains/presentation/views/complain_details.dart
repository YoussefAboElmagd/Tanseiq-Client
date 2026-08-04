import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_states.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/bloc_listener/complains_details_bloc_listener.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/complain_details/complain_details_actions_row.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/complain_details/complain_details_description.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/complain_details/complain_details_title_row.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/complain_details/complian_details_item_design.dart';

class ComplainDetails extends StatefulWidget {
  const ComplainDetails({super.key, required this.id, required this.isCadana});
  final int? id;
  final bool isCadana;

  @override
  State<ComplainDetails> createState() => _ComplainDetailsState();
}

class _ComplainDetailsState extends State<ComplainDetails> {
  @override
  void initState() {
    super.initState();
    widget.isCadana
        ? ComplainsCubit.get(context).emitProblemCadanaById(id: widget.id ?? 0)
        : ComplainsCubit.get(context).emitProblemById(id: widget.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplainsCubit, ComplainsStates>(
      builder: (context, state) {
        var cubit = ComplainsCubit.get(context);
        if (state is GetProblemByIdLoadingState ||
            cubit.complainsDataById == null) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: customAppBar(context: context, title: 'تفاصيل البلاغ'),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomScrollView(
                cacheExtent: 1000,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      spacing: 20.h,
                      children: [
                        ComplainDetailsDescription(
                          description:
                              cubit.complainsDataById!.description ??
                              'لا يوجد وصف',
                        ),
                        ComplainDetailsTitleRow(
                          title:
                              cubit.complainsDataById?.problemType ??
                              'غير محدد',
                        ),
                        10.height,
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      spacing: 20.h,
                      children: [
                        ComplainDetailsItemDesign(
                          text1: 'رقم المخيم',
                          text2: cubit.complainsDataById!.camp ?? 'غير محدد ',
                        ),
                        ComplainDetailsItemDesign(
                          text1: 'المخيم',
                          text2:
                              cubit.complainsDataById!.campId.toString() ==
                                      'null'
                                  ? 'غير محدد'
                                  : cubit.complainsDataById!.campId.toString(),
                        ),
                        ComplainDetailsItemDesign(
                          text1: 'المنطقة',
                          text2: cubit.complainsDataById!.zone ?? 'غير محدد ',
                        ),
                        ComplainDetailsItemDesign(
                          text1: 'اسم المبلغ',
                          text2:
                              cubit.complainsDataById!.reporterName ??
                              'غير محدد ',
                        ),
                        ComplainDetailsItemDesign(
                          text1: 'هاتف المبلغ',
                          text2:
                              cubit.complainsDataById!.phoneNumber ??
                              'غير محدد ',
                        ),
                        ComplainDetailsItemDesign(
                          text1: 'العنوان',
                          text2:
                              cubit.complainsDataById!.address ?? 'غير محدد ',
                        ),
                        ComplainDetailsItemDesign(
                          text1: 'تاريخ التبليغ',
                          text2:
                              cubit.complainsDataById!.date == null
                                  ? 'غير محدد '
                                  : cubit.complainsDataById!.date!.split(
                                    'T',
                                  )[0],
                        ),
                        // const ComplainDetailsCampNameRow(),
                        // Image.asset(Assets.assetsImagesTrackingMap),
                        // CustomButton(
                        //   borderRadius: 12.r,
                        //   textStyle: TextStyles.font16WhiteBold,
                        //   title: 'بدأ تتبع',
                        //   onTap: () {},
                        // ),
                        // Image.asset(Assets.assetsImagesPrepareTint),
                        // CustomButton(
                        //   borderRadius: 12.r,
                        //   textStyle: TextStyles.font16WhiteBold,
                        //   title: 'عمل  تقرير',
                        //   onTap: () {},
                        // ),
                        // 20.height,
                        const ComplainsDetailsBlocListener(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: ComplainDetailsActionsRow(
            id: widget.id!,
            cubit: cubit,
          ),
        );
      },
    );
  }
}
