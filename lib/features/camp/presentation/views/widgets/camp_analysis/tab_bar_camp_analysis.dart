import 'package:flutter/material.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class TabBarCampAnalysis extends StatelessWidget {
  const TabBarCampAnalysis({super.key, this.onTap});
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: onTap,
      isScrollable: true,
      indicatorWeight: 4,
      tabAlignment: TabAlignment.center,
      tabs: const [
        Tab(text: 'الكل'),
        Tab(text: 'جاهز'),
        Tab(text: 'معلق'),
        Tab(text: 'جاري العمل'),
        Tab(text: 'مكتمل'),
      ],
      dividerColor: ColorsManager.soft3Grey,
      labelStyle: TextStyles.font16GreenBold,
      indicatorColor: ColorsManager.green,
      unselectedLabelStyle: TextStyles.font14Grey,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    );
  }
}
