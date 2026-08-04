// ignore_for_file: camel_case_types, constant_identifier_names

class Routes {
  // BaseLayer
  static const baseLayer = '/baseLayer';

  // Auth
  static const login = '/login';
  static const recoverAccount = '/recoverAccount';
  static const otp = '/otp';
  static const createNewPassowrd = '/createNewPassowrd';

  // Home
  static const home = '/home';
  // static const homeCamp = '/camps';
  static const campReadiness = '/camp-readiness';

  // Survey
  static const addAndDisplaySurveies = '/addAndDisplaySurveies';
  static const addSurvey = '/addSurvey';
  static const surveyDetails = '/surveyDetails';
  static const addNewSurveyFieldScreen1 = '/addNewSurveyFieldScreen1';
  static const addNewSurveyFieldScreen2 = '/addNewSurveyFieldScreen2';
  static const answersSurvey = '/answersSurvey';

  // Support
  static const support = '/support';
  static const displayAttachment = '/displayAttachment';
  static const displayNetworkAttachment = '/displayNetworkAttachment';

  // Team
  static const team = '/team';
  static const addNewUserTeam = '/addNewUserTeam';
  static const userTeamDetails = '/userTeamDetails';

  // Notifications
  static const notifications = '/notifications';

  // Map
  static const map = '/map';
  static const mapDisplayAllPoints = '/mapDisplayAllPoints';

  // Complain
  static const displayComplains = '/reports';
  static const displayPickedMap = '/displayPickedMap';
  static const addComplains = '/report-issue-form';
  static const complainsDetails = '/report-issue-details';
  static const displayNetworkImageList = '/displayNetworkImageList';
  static const complainAnalysis = '/complainAnalysis';

  // Camps
  static const camps = '/camps';
  static const campsInMina = '/mina-readiness';
  static const campDetails = '/campDetails';
  static const campDetailsInMina = '/campDetailsInMina';
  static const displayImages = '/displayImages';
  static const displayFiles = '/displayFiles';
  static const pdfViewer = '/pdfViewer';
  static const campAnalysis = '/campAnalysis';
  static const campDetailsTintPrepareAndAllWork =
      '/campDetailsTintPrepareAndAllWork';

  // Hypothesis
  static const displayHypothesis = '/displayHypothesis';
  static const hypothesisDetails = '/hypothesisDetails';
  static const electricityHypotheses = '/electricityHypotheses';
  static const waterHypothesis = '/waterHypothesis';

  // Asset Rentail
  static const assetRentail = '/rent-assets';
  static const rentailDetails = '/rentailDetails';
  static const trackRentail = '/track-rentail';
  static const acceptedAndRejectedRequest = '/acceptedAndRejectedRequest';

  // Recording Readings
  static const recordingReadings = '/record-reading';

  // Recording Readings
  static const readinessLicense = '/readiness-license';

  // Arafat Electricity Reading
  static const arafatElectricityReading = '/arafat-electricity-reading';
}
