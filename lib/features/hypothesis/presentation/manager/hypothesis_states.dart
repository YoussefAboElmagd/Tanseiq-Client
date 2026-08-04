abstract class HypothesisStates {}

class HypothesisInitial extends HypothesisStates {}

class ChangeIndexState extends HypothesisStates {}

class NoNewFilesAdded extends HypothesisStates {}

class UserCanceled extends HypothesisStates {}

class UserPickedFile extends HypothesisStates {}

class GetGeneratorsSerialsLoadingState extends HypothesisStates {}

class GetGeneratorsSerialsSuccessState extends HypothesisStates {}

class GetGeneratorsSerialsErrorState extends HypothesisStates {
  GetGeneratorsSerialsErrorState(this.message);
  final String message;
}

class GetGeneratorsSerialsPaginationLoadingState extends HypothesisStates {}

class GetGeneratorsSerialsPaginationSuccessState extends HypothesisStates {}

class GetGeneratorsSerialsPaginationErrorState extends HypothesisStates {
  GetGeneratorsSerialsPaginationErrorState(this.message);
  final String message;
}

class GetGeneratorsReadingLoadingState extends HypothesisStates {}

class GetGeneratorsReadingSuccessState extends HypothesisStates {}

class GetGeneratorsReadingErrorState extends HypothesisStates {
  GetGeneratorsReadingErrorState(this.message);
  final String message;
}

class SaveReadingLoadingState extends HypothesisStates {}

class SaveReadingSuccessState extends HypothesisStates {}

class SaveReadingErrorState extends HypothesisStates {
  SaveReadingErrorState(this.message);
  final String message;
}
