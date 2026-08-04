// ignore_for_file: camel_case_types

class ApiConstants {
  // Base Url
  // prod => https://api.sjctanseiq.com/
  // test => http://147.93.55.107:5237/
  // static const String baseUrl = 'http://147.93.55.107:5237/';
  static const String baseUrl = 'https://api.sjctanseiq.com/';
  static const String checkRoute =
      'System/User/GetUserRoutePermisionOnRouteUrl';

  // Authentication
  static const String userLogin = 'system/Authentication/Login';
  static const String userLogout = 'System/users/logout';
  static const String userSendOtp = 'System/Otp/generate';
  static const String userVerifyOtp =
      'system/Authentication/VerifyOtpAndLoginAsync';
  static const String userResetPassword = 'System/users/reset-password';
  static const String userResendOtp = 'system/Authentication/ResendOtp';

  // Surveys
  static const String usersSupport = 'System/Complaint/Save';
  static const String surveys = 'System/surveys';
  static const String surveysFields = 'System/surveys/fields';

  // Problems
  static const String problemById = 'System/Problem/GetById';
  static const String getProblemStatusGraph =
      'System/Problem/GetProblemStatusGraph';
  static const String getProblemTypesGraph =
      'System/Problem/GetProblemTypesGraph';
  static const String getDropDownProblemStatus =
      'System/Problem/GetProblemStatusDropDownList';
  static const String getComplainsTypes =
      'System/Problem/GetReportTypesOfProblem';
  static const String getAllProblems = 'System/Problem/GetPagedList';
  static const String getProblemTypes =
      'System/Problem/GetReportTypesOfProblem';
  static const String getProblemDetails = 'System/Problem/GetProblemDetails';
  static const String saveProblem = 'System/Problem/SaveAsMultipart';
  static const String getProblemSolvedCode = 'System/Problem/GetSolvedCodeById';
  static const String unSpecializedProblem =
      'System/Problem/UnSpecializedProblem';
  static const String resolveProblem = 'System/Problem/ResolveProblem';
  static const String saveComment = 'System/Comment/Save';
  // -- Cadana Problem
  static const String problemCadanaById = 'System/ProblemInCadana/GetById';
  static const String getAllProblemCadana =
      'System/ProblemInCadana/GetPagedList';
  static const String getProblemCadanaTypes =
      'System/ProblemInCadana/GetReportTypesOfProblem';
  static const String getProblemCadanaDetails =
      'System/ProblemInCadana/GetProblemDetails';
  static const String saveProblemCadana =
      'System/ProblemInCadana/SaveAsMultipart';

  // Camp
  static const String camp = 'System/HCamp';
  static const String getAllCamp = 'System/HCamp/GetAllDataHCamps';
  static const String getAllSquare = 'api/Square/GetDropDownList';
  static const String homeStatistics = '/api/Camp/CampCompletionStatistics';
  static const String allTents = 'api/Camp/GetPagedListCustome';
  static const String updateElectScore = 'api/Camp/UpdateElectScoresById';
  static const String electricalServices =
      'System/ElectricalServiceItem/GetPagedList';
  static const String zoneStatistics = 'System/FlutterApp/GetZoneStatistics';
  static const String campDetails = 'api/Camp/GetById';
  static const String preparingCampServices =
      'System/FlutterApp/GetTentServicesSection';
  static const String campBuildingWorks = 'System/BuildingTent/GetPagedList';
  static const String campPreparingWorks = 'System/PreparingTent/GetPagedList';
  static const String getTentAttachment = 'System/FlutterApp/GetTentAttachment';
  static const String updateCampWork = 'api/CampWorkDetail/CampWorkUpdate';
  static const String updateItem = 'System/ElectricalServiceItem/UpDateItem';
  static const String getCampPreparingWorks = '/api/CampWorkDetail/GetByCampId';
  static const String getFilterCompany =
      'System/Company/GetDropDownListRentalCompany';
  static const String getAllCampNumber = 'api/Camp/GetAllCampNumberByZone';
  static const String getAllCamps = 'api/Camp/GetDropDownList';
  static const String checkPackage = '/System/Problem/CheckPackage';

  static const String getDropDownZoneFilter = 'System/Zone/GetDropDownList';
  static const String getDropDownDeveloper =
      'System/Company/GetDropDownListDeveloper';
  static const String getCampPercentage =
      'api/Camp/GetCampPercentageBasedOnRentalCompanies';
  static const String getClassification =
      'System/Term/GetCampWorkScoreOfTermClassifications';
  static const String getTerm = 'System/Term/GetCampWorkScoreOfTerm';

  // Generators
  static const String getSerialsGenerators =
      'System/ElectricalGenerator/GetAllGeneratorsSerials';
  static const String getSerialsGeneratorsPagination =
      'System/ElectricalGenerator/GetAllGeneratorsSerialsPagination';
  static const String getMapPoints = 'System/ElectricalGenerator/GetMapPoints';
  static const String saveReading = 'System/GeneratorReading/Save';
  static const String getReadings = 'System/GeneratorReading/GetPagedList';
  static const String getReadingsView =
      'System/GeneratorReading/GetReadingsView';

  // Assets Rentail
  static const String getRejectedAssets =
      'System/RejectedRentalApplication/GetPagedList';
  static const String getAllAssets = 'System/order/GetPagedList';

  // Hypotheses
  static const String getAllZonesWaterHypotheses =
      'System/WaterHypothesis/GetAllZones';
  static const String getAllSquaresWaterHypotheses =
      'System/WaterHypothesis/GetAllSquares';
  static const String getAllCampsByCompanyId =
      'System/WaterHypothesis/GetAllCampsByCompanyIdAsync';
  static const String getAllWaterCamps = 'System/WaterHypothesis/GetAllCamp';
  static const String getAllNoteTypesWaterHypotheses =
      'System/WaterHypothesis/note-types';
  static const String addWaterHypothesis = 'System/WaterHypothesis/Save';

  static const String getElectricZones = 'System/Zone/GetDropDownList';
  static const String getElectricSquare = 'api/Square/GetDropDownList';
  static const String saveElectricHypothesis =
      'System/ElectricalHypotheses/Save';
}

class ApiErrors {
  static const String badRequestError = 'badRequestError';
  static const String noContent = 'noContent';
  static const String forbiddenError = 'forbiddenError';
  static const String unauthorizedError = 'unauthorizedError';
  static const String notFoundError = 'notFoundError';
  static const String conflictError = 'conflictError';
  static const String internalServerError = 'internalServerError';
  static const String unknownError = 'unknownError';
  static const String timeoutError = 'timeoutError';
  static const String defaultError = 'يوجد مشكلة بالخادم او في الانترنت';
  static const String cacheError = 'cacheError';
  static const String noInternetError = 'noInternetError';
  static const String loadingMessage = 'loading_message';
  static const String retryAgainMessage = 'retry_again_message';
  static const String ok = 'Ok';
}
