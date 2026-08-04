import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/di/dependency_injection.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/widgets/display_attachment.dart';
import 'package:tanseiq/core/widgets/display_network_attachment.dart';
import 'package:tanseiq/core/widgets/display_network_image_list.dart';
import 'package:tanseiq/core/widgets/pdf_viewer.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_cubit.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/accepted_and_rejected_request.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/asset_rentail.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/rentail_details.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/track_rentail.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tanseiq/features/auth/presentation/views/create_new_password.dart';
import 'package:tanseiq/features/auth/presentation/views/login.dart';
import 'package:tanseiq/features/auth/presentation/views/otp.dart';
import 'package:tanseiq/features/auth/presentation/views/recover_account.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_cubit.dart';
import 'package:tanseiq/features/base/presentation/manager/ui_state.dart';
import 'package:tanseiq/features/base/presentation/views/base_layer.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/views/camp.dart';
import 'package:tanseiq/features/camp/presentation/views/camp_analysis.dart';
import 'package:tanseiq/features/camp/presentation/views/camp_details.dart';
import 'package:tanseiq/features/camp/presentation/views/camp_details_mina.dart';
import 'package:tanseiq/features/camp/presentation/views/camp_details_tint_prepare_and_all_work.dart';
import 'package:tanseiq/features/camp/presentation/views/camp_in_mina.dart';
import 'package:tanseiq/features/camp/presentation/views/display_files.dart';
import 'package:tanseiq/features/camp/presentation/views/display_images.dart';
import 'package:tanseiq/features/complains/data/models/get_all_complains_response.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/views/add_complain.dart';
import 'package:tanseiq/features/complains/presentation/views/complain_analysis.dart';
import 'package:tanseiq/features/complains/presentation/views/complain_details.dart';
import 'package:tanseiq/features/complains/presentation/views/display_complains.dart';
import 'package:tanseiq/features/complains/presentation/views/display_picked_map.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_cubit.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/electricity_hypotheses.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/views/water_hypothesis.dart';
import 'package:tanseiq/features/home/presentation/views/home.dart';
import 'package:tanseiq/features/hypothesis/presentation/manager/hypothesis_cubit.dart';
import 'package:tanseiq/features/hypothesis/presentation/views/display_hypothesis.dart';
import 'package:tanseiq/features/hypothesis/presentation/views/hypothesis_details.dart';
import 'package:tanseiq/features/map/presentation/manager/map_cubit.dart';
import 'package:tanseiq/features/map/presentation/views/map_display.dart';
import 'package:tanseiq/features/map/presentation/views/map_display_all_points.dart';
import 'package:tanseiq/features/notifications/presentation/views/notifications.dart';
import 'package:tanseiq/features/readiness_license/presentation/cubit/readiness_license_cubit.dart';
import 'package:tanseiq/features/readiness_license/presentation/views/readiness_license.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/manager/readiness_monitoring_cubit.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/views/readiness_monitoring.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/manager/arafat_electricity_cubit.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/views/arafat_electricity_screen.dart';
import 'package:tanseiq/features/recording_readings/presentation/manager/recording_readings_cubit.dart';
import 'package:tanseiq/features/recording_readings/presentation/views/recording_readings.dart';
import 'package:tanseiq/features/support/presentation/manager/support_cubit.dart';
import 'package:tanseiq/features/support/presentation/views/support.dart';
import 'package:tanseiq/features/surveys/presentation/manager/survey_cubit.dart';
import 'package:tanseiq/features/surveys/presentation/views/add_and_display_surveys.dart';
import 'package:tanseiq/features/surveys/presentation/views/add_new_survey_field_screen1.dart';
import 'package:tanseiq/features/surveys/presentation/views/add_new_survey_field_screen2.dart';
import 'package:tanseiq/features/surveys/presentation/views/add_survey.dart';
import 'package:tanseiq/features/surveys/presentation/views/answers_survey.dart';
import 'package:tanseiq/features/surveys/presentation/views/survey_details.dart';
import 'package:tanseiq/features/team/presentation/views/add_new_user_team.dart';
import 'package:tanseiq/features/team/presentation/views/team.dart';
import 'package:tanseiq/features/team/presentation/views/user_team_details.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    var arg = settings.arguments;
    switch (settings.name) {
      // BaseLayer
      case Routes.baseLayer:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => UiCubit(getit()),
                child: BlocListener<UiCubit, UiState>(
                  listener: (context, state) {
                    if (state is CheckRouteLoading) {
                      showDialog(
                        context: context,
                        builder:
                            (context) =>
                                PopScope(canPop: true, child: circular),
                      );
                    }
                    if (state is CheckRouteSuccess) {
                      context.popAlert();
                    }
                    if (state is CheckRouteError) {
                      context.popAlert();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(customSnackBar(message: state.error));
                    }
                  },
                  child: const BaseLayer(),
                ),
              ),
        );

      // Auth
      case Routes.login:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AuthCubit(getit()),
                child: const Login(),
              ),
        );
      case Routes.recoverAccount:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AuthCubit(getit()),
                child: const RecoverAccount(),
              ),
        );
      case Routes.otp:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AuthCubit(getit()),
                child: OTP(
                  email: data['email'] as String,
                  isFromLogin: data['isFromLogin'] as bool,
                  isFromRecover: data['isFromRecover'] as bool,
                ),
              ),
        );
      case Routes.createNewPassowrd:
        Map<String, Object> data = arg as Map<String, Object>;

        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AuthCubit(getit()),
                child: CreateNewPassowrd(email: data['email'] as String),
              ),
        );

      // Camp Readiness
      case Routes.campReadiness:
        Map<String, Object> data = arg as Map<String, Object>;
        print('data $data');
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ReadinessMonitoringCubit(getit()),
                child: ReadinessMonitoring(
                  total: data['total'] as int,
                  inProgress: data['inProgress'] as int,
                  compelete: data['compelete'] as int,
                  delay: data['delay'] as int,
                  canAdd: data['canAdd'] as bool?,
                  canEdit: data['canEdit'] as bool?,
                  canDelete: data['canDelete'] as bool?,
                  canList: data['canList'] as bool?,
                  isDeleted: data['isDeleted'] as bool?,
                ),
              ),
        );

      // Home
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const Home());

      // Survey
      case Routes.addAndDisplaySurveies:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => SurveyCubit(getit()),
                child: const AddAndDisplaySurveys(),
              ),
        );
      case Routes.addSurvey:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => SurveyCubit(getit()),
                child: const AddSurvey(),
              ),
        );
      case Routes.surveyDetails:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => SurveyCubit(getit()),
                child: SurveyDetails(id: data['id'] as String),
              ),
        );
      case Routes.addNewSurveyFieldScreen1:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => AddNewSurveyFieldScreen1(id: data['id'] as String),
        );
      case Routes.addNewSurveyFieldScreen2:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => SurveyCubit(getit()),
                child: AddNewSurveyFieldScreen2(
                  id: data['id'] as String,
                  attributeName: data['attributeName'] as String,
                ),
              ),
        );
      case Routes.answersSurvey:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => SurveyCubit(getit()),
                child: AnswersSurvey(id: data['id'] as String),
              ),
        );

      // Support
      case Routes.support:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => SupportCubit(getit()),
                child: const Support(),
              ),
        );
      case Routes.displayAttachment:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => DisplayAttachment(
                extention: data['extention'] as String,
                attachmentPath: data['attachmentPath'] as String,
              ),
        );
      case Routes.displayNetworkAttachment:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => DisplayNetworkAttachment(
                extention: data['extention'] as String,
                attachmentPath: data['attachmentPath'] as String,
              ),
        );

      // Team
      case Routes.team:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(builder: (context) => const Team());
      case Routes.addNewUserTeam:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(builder: (context) => const AddNewUserTeam());
      case Routes.userTeamDetails:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(builder: (context) => const UserTeamDetails());

      // Notifications
      case Routes.notifications:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(builder: (context) => const Notifications());

      // Map
      case Routes.map:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => MapDisplay(
                lat: data['lat'] as double,
                lng: data['lng'] as double,
                information: data['information'] as String,
              ),
        );
      case Routes.mapDisplayAllPoints:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => MapCubit(getit()),
                child: const MapDisplayAllPoints(),
              ),
        );

      // Complains
      case Routes.addComplains:
        Map<String, Object>? data = arg as Map<String, Object>?;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider.value(
                value: ComplainsCubit(getit()),
                child: const AddComplain(
                  // isCadana: data?['isCadana'] ,
                  // markers: data?['markers'] as Set<Marker>,
                ),
              ),
        );
      case Routes.displayComplains:
        // Map<String, Object> data = arg as Map<String, Object>;
        // print("data $data");
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ComplainsCubit(getit()),
                // child: DisplayComplains(canAdd: data['canAdd'] as bool?),
                child: const DisplayComplains(canAdd: true),
              ),
        );
      case Routes.displayPickedMap:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ComplainsCubit(getit()),
                child: const DisplayPickedMap(),
              ),
        );
      case Routes.complainsDetails:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ComplainsCubit(getit()),
                child: ComplainDetails(
                  isCadana: data['isCadana'] as bool,
                  id: data['id'] as int?,
                ),
              ),
        );
      case Routes.displayNetworkImageList:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => DisplayNetworkImageList(
                pathes: data['pathes'] as List<ProblemMediaData>,
              ),
        );
      case Routes.complainAnalysis:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ComplainsCubit(getit()),
                child: const ComplainAnalysis(),
              ),
        );

      // Camps
      case Routes.camps:
        var data = arg as Map;
        // print("data $data");
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => CampCubit(getit()),
                child: Camp(
                  canAdd: data['canAdd'] as bool?,
                  canEdit: data['canEdit'] as bool?,
                  canDelete: data['canDelete'] as bool?,
                  canList: data['canList'] as bool?,
                  isDeleted: data['isDeleted'] as bool?,
                ),
              ),
        );
      case Routes.campsInMina:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => CampCubit(getit()),
                child: CampInMina(
                  canAdd: data['canAdd'] as bool?,
                  canDelete: data['canDelete'] as bool?,
                  canEdit: data['canEdit'] as bool?,
                  canList: data['canList'] as bool?,
                  isDeleted: data['isDeleted'] as bool?,
                ),
              ),
        );
      case Routes.campDetails:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => CampCubit(getit()),
                child: CampDetails(campId: data['campId'] as String),
              ),
        );
      case Routes.campDetailsInMina:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => CampCubit(getit()),
                child: CampDetailsMina(campId: data['campId'] as String),
              ),
        );
      case Routes.displayImages:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider.value(
                value: CampCubit(getit()),
                child: DisplayImages(images: data['images'] as List<File>),
              ),
        );
      case Routes.campAnalysis:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider.value(
                value: CampCubit(getit()),
                child: const CampAnalysis(),
              ),
        );
      case Routes.readinessLicense:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider.value(
                value: ReadinessLicenseCubit(),
                child: const ReadinessLicense(),
              ),
        );
      case Routes.displayFiles:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider.value(
                value: CampCubit(getit()),
                child: DisplayFiles(files: data['files'] as List<File>),
              ),
        );
      case Routes.pdfViewer:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder: (context) => PdfViewer(path: data['path'] as String),
        );
      case Routes.campDetailsTintPrepareAndAllWork:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => CampCubit(getit()),
                child: const CampDetailsTintPrepareAndAllWork(
                  // currentIndex: data['currentIndex'] as int,
                  currentIndex: 0,
                ),
              ),
        );

      // Hypothesis
      case Routes.displayHypothesis:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => HypothesisCubit(getit()),
                child: const DisplayHypothesis(),
              ),
        );
      case Routes.hypothesisDetails:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => HypothesisCubit(getit()),
                child: const HypothesisDetails(),
              ),
        );

      case Routes.electricityHypotheses:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ElectricityHypothesesCubit(getit()),
                child: const ElectricityHypotheses(),
              ),
        );

      case Routes.waterHypothesis:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ElectricityHypothesesCubit(getit()),
                child: const WaterHypothesis(),
              ),
        );

      // Asset Rentail
      case Routes.assetRentail:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AssetRentailCubit(getit()),
                child: const AssetRentail(),
              ),
        );
      case Routes.rentailDetails:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AssetRentailCubit(getit()),
                child: const RentailDetails(),
              ),
        );
      case Routes.trackRentail:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AssetRentailCubit(getit()),
                child: const TrackRentail(),
              ),
        );
      case Routes.acceptedAndRejectedRequest:
        Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AssetRentailCubit(getit()),
                child: AcceptedAndRejectedRequest(
                  isRejected: data['isRejected'] as bool,
                ),
              ),
        );

      // Recording Readings
      case Routes.recordingReadings:
        // Map<String, Object> data = arg as Map<String, Object>;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => RecordingReadingsCubit(getit()),
                child: const RecordingReadings(),
              ),
        );

      // Arafat Electricity Reading
      case Routes.arafatElectricityReading:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ArafatElectricityCubit(getit()),
                child: const ArafatElectricityScreen(),
              ),
        );
    }
    return null;
  }
}
