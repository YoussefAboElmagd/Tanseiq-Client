import 'package:flutter/material.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/base/presentation/views/widget/bottom_nav_bar_design.dart';

class BottomNavigationBarItemButton extends StatelessWidget {
  const BottomNavigationBarItemButton({super.key, required this.cubit});
  final UiCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            if (cubit.currentIndex == 0) {
              final currentNavigatorState =
                  cubit.navigatorKeys[cubit.currentIndex].currentState;
              if (currentNavigatorState != null &&
                  currentNavigatorState.canPop()) {
                currentNavigatorState.popUntil((route) => route.isFirst);
              }
            } else {
              cubit.emitChangeBottomNav(0);
            }
          },
          child: BottomNavBarItemDesign(
            index: 0,
            currentIndex: cubit.currentIndex,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (cubit.currentIndex == 1) {
              final currentNavigatorState =
                  cubit.navigatorKeys[cubit.currentIndex].currentState;
              if (currentNavigatorState != null &&
                  currentNavigatorState.canPop()) {
                currentNavigatorState.popUntil((route) => route.isFirst);
              }
            } else {
              cubit.emitChangeBottomNav(1);
            }
          },
          child: BottomNavBarItemDesign(
            index: 1,
            currentIndex: cubit.currentIndex,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (cubit.currentIndex == 2) {
              final currentNavigatorState =
                  cubit.navigatorKeys[cubit.currentIndex].currentState;
              if (currentNavigatorState != null &&
                  currentNavigatorState.canPop()) {
                currentNavigatorState.popUntil((route) => route.isFirst);
              }
            } else {
              cubit.emitChangeBottomNav(2);
            }
          },
          child: BottomNavBarItemDesign(
            index: 2,
            currentIndex: cubit.currentIndex,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (cubit.currentIndex == 3) {
              final currentNavigatorState =
                  cubit.navigatorKeys[cubit.currentIndex].currentState;
              if (currentNavigatorState != null &&
                  currentNavigatorState.canPop()) {
                currentNavigatorState.popUntil((route) => route.isFirst);
              }
            } else {
              cubit.emitChangeBottomNav(3);
            }
          },
          child: BottomNavBarItemDesign(
            index: 3,
            currentIndex: cubit.currentIndex,
          ),
        ),
      ],
    );
  }
}
