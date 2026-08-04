import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/select_date.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_analysis/tab_bar_camp_analysis.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_analysis/terms_item_design.dart';

class Terms extends StatefulWidget {
  const Terms({super.key, required this.cubit, required this.state});
  final CampCubit cubit;
  final CampStates state;

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  void initState() {
    super.initState();
    widget.cubit.emitGetTerms(company: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      children: [
        DropDownList(
          borderColor: ColorsManager.soft2Green,
          iconColor: ColorsManager.green2,
          text: 'الكل',
          list: const ['الكل', 'مني', 'عرفات'],
          selectedValue: widget.cubit.zoneId,
          onChanged: (value) {
            widget.cubit.zoneId = getZoneId(value!);
            widget.cubit.emitGetTerms(
              company: 0,
              status: widget.cubit.currentIndexTabBar,
              modifiedDate: Constant.startDate,
            );
          },
        ),
        SelectDate(
          onChanged: (value) async {
            Constant.startDate = value;
            await widget.cubit.emitGetTerms(
              company: 0,
              status: widget.cubit.currentIndexTabBar,
              modifiedDate: Constant.startDate,
            );
          },
          borderColor: ColorsManager.soft2Green,
          iconColor: ColorsManager.green2,
        ),
        TabBarCampAnalysis(
          onTap: (value) async {
            if (value != widget.cubit.currentIndexTabBar) {
              widget.cubit.currentIndexTabBar = value;
              await widget.cubit.emitGetTerms(
                company: 0,
                status: widget.cubit.currentIndexTabBar,
                modifiedDate: Constant.startDate,
              );
            }
          },
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              widget.state is GetCampPercentageLoadingState
                  ? circular
                  : widget.state is GetCampPercentageErrorState
                  ? const EmptyList()
                  : widget.cubit.terms.isEmpty
                  ? EmptyList(
                    image: Assets.assetsImagesTint,
                    imageColor: ColorsManager.green,
                    textStyle: TextStyles.font16GreenBold,
                  )
                  : TermsItemDesign(
                    campAnalysis: widget.cubit.terms,
                    onRefresh: () async {
                      await widget.cubit.emitGetTerms(company: 0, status: 0);
                    },
                  ),
              widget.state is GetCampPercentageLoadingState
                  ? circular
                  : widget.state is GetCampPercentageErrorState
                  ? const EmptyList()
                  : widget.cubit.terms.isEmpty
                  ? EmptyList(
                    image: Assets.assetsImagesTint,
                    imageColor: ColorsManager.green,
                    textStyle: TextStyles.font16GreenBold,
                  )
                  : TermsItemDesign(
                    campAnalysis: widget.cubit.terms,
                    onRefresh: () async {
                      await widget.cubit.emitGetTerms(company: 0, status: 0);
                    },
                  ),
              widget.state is GetCampPercentageLoadingState
                  ? circular
                  : widget.state is GetCampPercentageErrorState
                  ? const EmptyList()
                  : widget.cubit.terms.isEmpty
                  ? EmptyList(
                    image: Assets.assetsImagesTint,
                    imageColor: ColorsManager.green,
                    textStyle: TextStyles.font16GreenBold,
                  )
                  : TermsItemDesign(
                    campAnalysis: widget.cubit.terms,
                    onRefresh: () async {
                      await widget.cubit.emitGetTerms(company: 0, status: 0);
                    },
                  ),
              widget.state is GetCampPercentageLoadingState
                  ? circular
                  : widget.state is GetCampPercentageErrorState
                  ? const EmptyList()
                  : widget.cubit.terms.isEmpty
                  ? EmptyList(
                    image: Assets.assetsImagesTint,
                    imageColor: ColorsManager.green,
                    textStyle: TextStyles.font16GreenBold,
                  )
                  : TermsItemDesign(
                    campAnalysis: widget.cubit.terms,
                    onRefresh: () async {
                      await widget.cubit.emitGetTerms(company: 0, status: 0);
                    },
                  ),
              widget.state is GetCampPercentageLoadingState
                  ? circular
                  : widget.state is GetCampPercentageErrorState
                  ? const EmptyList()
                  : widget.cubit.terms.isEmpty
                  ? EmptyList(
                    image: Assets.assetsImagesTint,
                    imageColor: ColorsManager.green,
                    textStyle: TextStyles.font16GreenBold,
                  )
                  : TermsItemDesign(
                    campAnalysis: widget.cubit.terms,
                    onRefresh: () async {
                      await widget.cubit.emitGetTerms(company: 0, status: 0);
                    },
                  ),
            ],
          ),
        ),
      ],
    );
  }

  String getZoneId(String zone) {
    if (zone == 'مني') {
      return '1';
    } else if (zone == 'عرفات') {
      return '2';
    } else {
      return '0';
    }
  }
}
