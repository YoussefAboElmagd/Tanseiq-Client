// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tanseiq/core/networking/dio_factory.dart';
import 'package:tanseiq/features/asset_rentail/data/apis/asset_rentail_api_services.dart';
import 'package:tanseiq/features/asset_rentail/data/repos/assets_rentail_repo.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_cubit.dart';
import 'package:tanseiq/features/auth/data/apis/auth_api_services.dart';
import 'package:tanseiq/features/auth/data/repos/auth_repo.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tanseiq/features/base/data/apis/base_api_services.dart';
import 'package:tanseiq/features/base/data/repo/base_repo.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/camp/data/apis/camp_api_services.dart';
import 'package:tanseiq/features/camp/data/repo/camp_repo.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/complains/data/apis/complains_api_services.dart';
import 'package:tanseiq/features/complains/data/repos/complains_repo.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/arafat_electricity_reading/data/apis/arafat_electricity_api_services.dart';
import 'package:tanseiq/features/arafat_electricity_reading/data/repos/arafat_electricity_repo.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/manager/arafat_electricity_cubit.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/apis/electricity_hypotheses_api_services.dart';
import 'package:tanseiq/features/electricity_hypotheses/data/repos/electricity_hypotheses_repo.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_cubit.dart';
import 'package:tanseiq/features/home/data/apis/home_api_services.dart';
import 'package:tanseiq/features/home/data/repos/home_repo.dart';
import 'package:tanseiq/features/home/presentation/manager/home_cubit.dart';
import 'package:tanseiq/features/hypothesis/data/apis/hypothesis_api_services.dart';
import 'package:tanseiq/features/hypothesis/data/repos/hypothesis_repo.dart';
import 'package:tanseiq/features/hypothesis/presentation/manager/hypothesis_cubit.dart';
import 'package:tanseiq/features/map/data/apis/map_api_services.dart';
import 'package:tanseiq/features/map/data/repos/map_repo.dart';
import 'package:tanseiq/features/map/presentation/manager/map_cubit.dart';
import 'package:tanseiq/features/readiness_monitoring/data/apis/readiness_api_services.dart';
import 'package:tanseiq/features/readiness_monitoring/data/repos/readiness_repo.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/manager/readiness_monitoring_cubit.dart';
import 'package:tanseiq/features/recording_readings/data/apis/recording_readings_api_services.dart';
import 'package:tanseiq/features/recording_readings/data/repo/recording_readings_repo.dart';
import 'package:tanseiq/features/recording_readings/presentation/manager/recording_readings_cubit.dart';
import 'package:tanseiq/features/support/data/apis/support_api_services.dart';
import 'package:tanseiq/features/support/data/repos/support_repo.dart';
import 'package:tanseiq/features/support/presentation/manager/support_cubit.dart';
import 'package:tanseiq/features/surveys/data/apis/survey_api_services.dart';
import 'package:tanseiq/features/surveys/data/repos/survey_repo.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_cubit.dart';

final getit = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = await DioFactory.getDio();

  getit.registerLazySingleton<BaseApiServices>(() => BaseApiServices(dio));
  getit.registerLazySingleton<BaseRepo>(
    () => BaseRepo(getit<BaseApiServices>()),
  );
  getit.registerFactory<UiCubit>(() => UiCubit(getit()));

  // Home
  getit.registerLazySingleton<HomeApiServices>(() => HomeApiServices(dio));
  getit.registerLazySingleton<HomeRepo>(
    () => HomeRepo(getit<HomeApiServices>()),
  );
  getit.registerFactory<HomeCubit>(() => HomeCubit(getit()));

  // Readiness Monitoring
  getit.registerLazySingleton<ReadinessApiServices>(
    () => ReadinessApiServices(dio),
  );
  getit.registerLazySingleton<ReadinessRepo>(
    () => ReadinessRepo(getit<ReadinessApiServices>()),
  );
  getit.registerFactory<ReadinessMonitoringCubit>(
    () => ReadinessMonitoringCubit(getit()),
  );

  // Auth
  getit.registerLazySingleton<AuthApiService>(() => AuthApiService(dio));
  getit.registerLazySingleton<AuthRepo>(
    () => AuthRepo(getit<AuthApiService>()),
  );
  getit.registerFactory<AuthCubit>(() => AuthCubit(getit()));

  // Survey
  getit.registerLazySingleton<SurveyApiServices>(() => SurveyApiServices(dio));
  getit.registerLazySingleton<SurveyRepo>(
    () => SurveyRepo(getit<SurveyApiServices>()),
  );
  getit.registerFactory<SurveyCubit>(() => SurveyCubit(getit()));

  // Support
  getit.registerLazySingleton<SupportApiServices>(
    () => SupportApiServices(dio),
  );
  getit.registerLazySingleton<SupportRepo>(
    () => SupportRepo(getit<SupportApiServices>()),
  );
  getit.registerFactory<SupportCubit>(() => SupportCubit(getit()));

  // Problem
  getit.registerLazySingleton<ComplainsApiServices>(
    () => ComplainsApiServices(dio),
  );
  getit.registerLazySingleton<ComplainsRepo>(
    () => ComplainsRepo(getit<ComplainsApiServices>()),
  );
  getit.registerFactory<ComplainsCubit>(() => ComplainsCubit(getit()));

  // Camp
  getit.registerLazySingleton<CampApiServices>(() => CampApiServices(dio));
  getit.registerLazySingleton<CampRepo>(
    () => CampRepo(getit<CampApiServices>()),
  );
  getit.registerFactory<CampCubit>(() => CampCubit(getit()));

  // Map
  getit.registerLazySingleton<MapApiServices>(() => MapApiServices(dio));
  getit.registerLazySingleton<MapRepo>(() => MapRepo(getit<MapApiServices>()));
  getit.registerFactory<MapCubit>(() => MapCubit(getit()));

  // Recording Readings
  getit.registerLazySingleton<RecordingReadingsApiServices>(
    () => RecordingReadingsApiServices(dio),
  );
  getit.registerLazySingleton<RecordingReadingsRepo>(
    () => RecordingReadingsRepo(getit<RecordingReadingsApiServices>()),
  );
  getit.registerFactory<RecordingReadingsCubit>(
    () => RecordingReadingsCubit(getit()),
  );

  // Map
  getit.registerLazySingleton<HypothesisApiServices>(
    () => HypothesisApiServices(dio),
  );
  getit.registerLazySingleton<HypothesisRepo>(
    () => HypothesisRepo(getit<HypothesisApiServices>()),
  );
  getit.registerFactory<HypothesisCubit>(() => HypothesisCubit(getit()));

  // Asset Rentail
  getit.registerLazySingleton<AssetRentailApiServices>(
    () => AssetRentailApiServices(dio),
  );
  getit.registerLazySingleton<AssetsRentailRepo>(
    () => AssetsRentailRepo(getit<AssetRentailApiServices>()),
  );
  getit.registerFactory<AssetRentailCubit>(() => AssetRentailCubit(getit()));

  // Arafat Electricity Reading
  getit.registerLazySingleton<ArafatElectricityApiServices>(
    () => ArafatElectricityApiServices(dio),
  );
  getit.registerLazySingleton<ArafatElectricityRepo>(
    () => ArafatElectricityRepo(getit<ArafatElectricityApiServices>()),
  );
  getit.registerFactory<ArafatElectricityCubit>(
    () => ArafatElectricityCubit(getit()),
  );

  // Electricity Hypotheses
  getit.registerLazySingleton<ElectricityHypothesesApiServices>(
    () => ElectricityHypothesesApiServices(dio),
  );
  getit.registerLazySingleton<ElectricityHypothesesRepo>(
    () => ElectricityHypothesesRepo(getit<ElectricityHypothesesApiServices>()),
  );
  getit.registerFactory<ElectricityHypothesesCubit>(
    () => ElectricityHypothesesCubit(getit()),
  );
}
