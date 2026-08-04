import 'package:flutter/material.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CampDetailsTabBar extends StatelessWidget {
  const CampDetailsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorWeight: 4,
      tabAlignment: TabAlignment.center,
      tabs: const [Tab(text: 'اعمال للمخيم بالكامل')],
      dividerColor: ColorsManager.soft3Grey,
      labelStyle: TextStyles.font16MainColorBold,
      indicatorColor: ColorsManager.mainColor,
      unselectedLabelStyle: TextStyles.font14Grey,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    );
  }
}
