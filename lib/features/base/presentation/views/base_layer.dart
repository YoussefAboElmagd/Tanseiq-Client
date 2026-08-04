import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/routing/app_router.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_state.dart';
import 'package:tanseiq/features/base/presentation/views/widget/bottom_nav_bar.dart';

class BaseLayer extends StatelessWidget {
  const BaseLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UiCubit, UiState>(
      builder: (context, state) {
        var cubit = UiCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            return !await cubit.navigatorKeys[cubit.currentIndex].currentState!
                .maybePop();
          },
          child: Scaffold(
            body: Stack(
              children: List.generate(cubit.pages.length, (index) {
                return Offstage(
                  offstage: cubit.currentIndex != index,
                  child: Visibility(
                    visible: cubit.currentIndex == index,
                    child: Navigator(
                      key: cubit.navigatorKeys[index],
                      onGenerateInitialRoutes:
                          (navigator, initialRoute) => [
                            MaterialPageRoute(
                              builder: (context) => cubit.getPage(index),
                            ),
                          ],
                      onGenerateRoute: (routeSettings) {
                        return AppRouter().generateRoute(routeSettings);
                      },
                    ),
                  ),
                );
              }),
            ),
            bottomNavigationBar: SafeArea(
              bottom: true,
              maintainBottomViewPadding: true,
              child: BottomNavBar(cubit: cubit),
            ),
          ),
        );
      },
    );
  }
}
