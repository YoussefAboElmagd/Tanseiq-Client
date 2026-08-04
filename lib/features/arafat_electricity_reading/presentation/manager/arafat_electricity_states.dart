abstract class ArafatElectricityStates {}

class ArafatElectricityInitialState extends ArafatElectricityStates {}

class GetGeneratorsSerialsLoadingState extends ArafatElectricityStates {}

class GetGeneratorsSerialsSuccessState extends ArafatElectricityStates {}

class GetGeneratorsSerialsErrorState extends ArafatElectricityStates {
  final String message;
  GetGeneratorsSerialsErrorState(this.message);
}

class ArafatUserPickedFileState extends ArafatElectricityStates {}

class ArafatUserCanceledState extends ArafatElectricityStates {}

class SaveArafatReadingLoadingState extends ArafatElectricityStates {}

class SaveArafatReadingSuccessState extends ArafatElectricityStates {}

class SaveArafatReadingErrorState extends ArafatElectricityStates {
  final String message;
  SaveArafatReadingErrorState(this.message);
}

class ArafatAccessRestrictedState extends ArafatElectricityStates {}
