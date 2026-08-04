abstract class ComplainsStates {}

class ComplainsInitial extends ComplainsStates {}

class ChangeIndexState extends ComplainsStates {}

class SelectLocationState extends ComplainsStates {}

class UserPickedFile extends ComplainsStates {}

class UserCanceled extends ComplainsStates {}

class NoNewFilesAdded extends ComplainsStates {}

class UploadLoadingComplainstate extends ComplainsStates {}

class UploadSuccessComplainstate extends ComplainsStates {}

class UploadErrorComplainstate extends ComplainsStates {
  final String errorMessage;
  UploadErrorComplainstate(this.errorMessage);
}

class GetAllComplainsLoadingState extends ComplainsStates {}

class GetAllComplainsSuccessState extends ComplainsStates {}

class GetAllComplainsErrorState extends ComplainsStates {
  final String errorMessage;
  GetAllComplainsErrorState(this.errorMessage);
}

class GetPaginatedComplainsLoadingState extends ComplainsStates {}

class GetPaginatedComplainsSuccessState extends ComplainsStates {}

class GetPaginatedComplainsErrorState extends ComplainsStates {
  final String errorMessage;
  GetPaginatedComplainsErrorState(this.errorMessage);
}

class GetAllCampNumberLoadingState extends ComplainsStates {}

class GetAllCampNumberSuccessState extends ComplainsStates {}

class GetAllCampNumberErrorState extends ComplainsStates {
  final String errorMessage;
  GetAllCampNumberErrorState(this.errorMessage);
}

class GetCheckLoadingState extends ComplainsStates {}

class GetCheckSuccessState extends ComplainsStates {}

class GetCheckErrorState extends ComplainsStates {
  final String errorMessage;
  GetCheckErrorState(this.errorMessage);
}

class GetZonesLoadingState extends ComplainsStates {}

class GetZonesSuccessState extends ComplainsStates {}

class GetZonesErrorState extends ComplainsStates {
  final String errorMessage;
  GetZonesErrorState(this.errorMessage);
}

class GetComplainTypeLoadingState extends ComplainsStates {}

class GetComplainTypeSuccessState extends ComplainsStates {}

class GetComplainTypeErrorState extends ComplainsStates {
  final String errorMessage;
  GetComplainTypeErrorState(this.errorMessage);
}

class AddComplainLoadingState extends ComplainsStates {}

class AddComplainSuccessState extends ComplainsStates {}

class AddComplainErrorState extends ComplainsStates {
  final String errorMessage;
  AddComplainErrorState(this.errorMessage);
}

class GetProblemByIdLoadingState extends ComplainsStates {}

class GetProblemByIdSuccessState extends ComplainsStates {}

class GetProblemByIdErrorState extends ComplainsStates {
  final String errorMessage;
  GetProblemByIdErrorState(this.errorMessage);
}

class GetCodeLoadingState extends ComplainsStates {}

class GetCodeSuccessState extends ComplainsStates {}

class GetCodeErrorState extends ComplainsStates {
  final String errorMessage;
  GetCodeErrorState(this.errorMessage);
}

class SaveCommentLoadingState extends ComplainsStates {}

class SaveCommentSuccessState extends ComplainsStates {}

class SaveCommentErrorState extends ComplainsStates {
  final String errorMessage;
  SaveCommentErrorState(this.errorMessage);
}

class UnSpecializedProblemLoadingState extends ComplainsStates {}

class UnSpecializedProblemSuccessState extends ComplainsStates {}

class UnSpecializedProblemErrorState extends ComplainsStates {
  final String errorMessage;
  UnSpecializedProblemErrorState(this.errorMessage);
}

class ProblemSolvedLoadingState extends ComplainsStates {}

class ProblemSolvedSuccessState extends ComplainsStates {}

class ProblemSolvedErrorState extends ComplainsStates {
  final String errorMessage;
  ProblemSolvedErrorState(this.errorMessage);
}

class GetProblemStatusLoadingState extends ComplainsStates {}

class GetProblemStatusSuccessState extends ComplainsStates {}

class GetProblemStatusErrorState extends ComplainsStates {
  final String errorMessage;
  GetProblemStatusErrorState(this.errorMessage);
}

class GetComplainOptionTypesLoadingState extends ComplainsStates {}

class GetComplainOptionTypesSuccessState extends ComplainsStates {}

class GetComplainOptionTypesErrorState extends ComplainsStates {
  final String errorMessage;
  GetComplainOptionTypesErrorState(this.errorMessage);
}

class GetComplainOtionTypesAnalysisLoadingState extends ComplainsStates {}

class GetComplainOtionTypesAnalysisSuccessState extends ComplainsStates {}

class GetComplainOtionTypesAnalysisErrorState extends ComplainsStates {
  final String errorMessage;
  GetComplainOtionTypesAnalysisErrorState(this.errorMessage);
}

class GetComplainStatusAnalysisLoadingState extends ComplainsStates {}

class GetComplainStatusAnalysisSuccessState extends ComplainsStates {}

class GetComplainStatusAnalysisErrorState extends ComplainsStates {
  final String errorMessage;
  GetComplainStatusAnalysisErrorState(this.errorMessage);
}
