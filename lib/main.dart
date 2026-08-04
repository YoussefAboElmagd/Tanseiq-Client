import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_log_care/live_log_care.dart';
import 'package:tanseiq/core/di/dependency_injection.dart';
import 'package:tanseiq/core/helpers/cach_helper.dart';
import 'package:tanseiq/core/routing/app_router.dart';
import 'package:tanseiq/tanseiq.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  // ── Logging (package: live_log_care) ───────────────────────────────────────
  // Use LiveLog.d/i/w/e(...) everywhere instead of print/debugPrint: every
  // message is redaction-scrubbed (passwords, tokens, cookies, OTPs, PII) and
  // gated by build mode (silent below `warning` in release).
  //  • clean(): borderless, copy-friendly output — each log is emitted as one
  //    dart:developer event, so multi-line JSON stays a single selectable block
  //    with no `I/flutter (PID): │` prefix in the VS Code Debug Console.
  //  • Secrets show in DEBUG only (revealSecretsInDebug defaults to kDebugMode);
  //    RELEASE is always redacted. Pass `revealSecretsInDebug: false` to redact
  //    in debug too (e.g. if debug logs may be screenshotted or shared).
  LiveLog.configure(LiveLogConfig.clean());
  await ScreenUtil.ensureScreenSize();
  await CachHelper.init();
  await setupGetIt();
  // Route every Bloc/Cubit lifecycle event (create/change/error/close) through
  // the same redaction-safe, build-gated pipeline as LiveLog.
  Bloc.observer = LiveLogBlocObserver();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      child: Tanseiq(appRouter: AppRouter()),
    ),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
