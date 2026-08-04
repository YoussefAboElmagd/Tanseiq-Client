import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/di/dependency_injection.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/features/base/data/repo/base_repo.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_state.dart';
import 'package:tanseiq/features/home/presentation/manager/home_cubit.dart';
import 'package:tanseiq/features/home/presentation/views/home.dart';
import 'package:tanseiq/features/profile/profile.dart';
import 'package:tanseiq/features/settings/settings.dart';
import 'package:tanseiq/features/support/presentation/manager/support_cubit.dart';
import 'package:tanseiq/features/support/presentation/views/support.dart';
import 'package:tanseiq/features/surveys/presentation/views/add_and_display_surveys.dart';

class UiCubit extends Cubit<UiState> {
  UiCubit(this.baseRepo) : super(Initial());
  static UiCubit get(context) => BlocProvider.of(context);
  final BaseRepo baseRepo;
  // bool switchedButton = CachHelper.getData(key: 'lang') != null
  //     ? CachHelper.getData(key: 'lang') == 'ar'
  //         ? true
  //         : false
  //     : false;

  // Locale locale = const Locale('en');
  // Future changeLange({
  //   required bool switched,
  // }) async {
  //   if (switched) {
  //     locale = const Locale('ar');
  //     switchedButton = switched;
  //     await CachHelper.saveData(key: 'lang', value: 'ar');
  //     emit(ChangeLanguage());
  //   } else {
  //     locale = const Locale('en');
  //     switchedButton = switched;
  //     await CachHelper.saveData(key: 'lang', value: 'en');
  //     emit(ChangeLanguage());
  //   }
  // }

  int currentIndex = 0;
  void emitChangeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  List<Widget> get pages => [
    const Profile(),
    const Settings(),
    const AddAndDisplaySurveys(),
    const Home(),
  ];

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return BlocProvider(
          create: (context) => HomeCubit(getit())..emitGetAllHome(),
          child: const Home(),
        );
      case 1:
        return BlocProvider(
          create: (context) => SupportCubit(getit()),
          child: const Support(),
        );
      case 2:
        return const Settings();
      case 3:
        return const Profile();
      default:
        return const Home();
    }
  }

  Future emitCheckRoute({
    required String route,
    required BuildContext context,
    Map<String, Object>? data,
    bool? routerNavigator,
  }) async {
    emit(CheckRouteLoading());
    final response = await baseRepo.checkRoute(routeName: route);
    await response.when(
      success: (success) async {
        if (success['isError'] == false &&
            (success['returnedValue'] != 0 &&
                success['returnedValue']['canList'] == true)) {
          if (data == null) {
            data = {'canAdd': success['returnedValue']['canAdd']};
          } else {
            data!.addAll({'canAdd': success['returnedValue']['canAdd']});
            data!.addAll({'canEdit': success['returnedValue']['canEdit']});
            data!.addAll({'canDelete': success['returnedValue']['canDelete']});
            data!.addAll({'canList': success['returnedValue']['canList']});
            data!.addAll({'isDeleted': success['returnedValue']['isDeleted']});
          }
          emit(CheckRouteSuccess());
          await context.pushNamed(
            route,
            arguments: data,
            routerNavigator: routerNavigator,
          );
        } else {
          emit(CheckRouteError('غير مسموح'));
        }
      },
      failure: (error) {
        emit(CheckRouteError(error.failure.message ?? ''));
      },
    );
  }
}
