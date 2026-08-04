abstract class SurveyState {}

class SurveyInitial extends SurveyState {}

class SurveyClear extends SurveyState {}

class SurveyLoading extends SurveyState {}

class SurveySuccess extends SurveyState {}

class SurveyError extends SurveyState {
  final String error;
  final bool isBack;
  SurveyError(this.error, this.isBack);
}

class GetAllSurveysLoading extends SurveyState {}

class GetAllSurveysSuccess extends SurveyState {}

class GetAllSurveysError extends SurveyState {
  final String error;
  GetAllSurveysError(this.error);
}

class GetSurveyByIdLoading extends SurveyState {}

class GetSurveyByIdSuccess extends SurveyState {}

class GetSurveyByIdError extends SurveyState {
  final String error;
  GetSurveyByIdError(this.error);
}

class UserPickedFile extends SurveyState {}

class UserCanceled extends SurveyState {}

class NoNewFilesAdded extends SurveyState {}
