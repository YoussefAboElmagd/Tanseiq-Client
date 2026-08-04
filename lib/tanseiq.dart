import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/routing/app_router.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/theming.dart';
import 'package:tanseiq/generated/l10n.dart';

class Tanseiq extends StatelessWidget {
  const Tanseiq({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute:
          CachHelper.getData(key: 'isLogged') != null &&
                  CachHelper.getData(key: 'isLogged')
              ? Routes.baseLayer
              : Routes.login,
      // initialRoute: Routes.login,
      // home: const OperationAndMaintenance(),
      theme: theme(),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
