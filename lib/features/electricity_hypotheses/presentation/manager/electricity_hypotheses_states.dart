abstract class ElectricityHypothesesStates {}

class ElectricityHypothesesInitial extends ElectricityHypothesesStates {}

class ChangeIndexState extends ElectricityHypothesesStates {}

class NoNewFilesAdded extends ElectricityHypothesesStates {}

class UserCanceled extends ElectricityHypothesesStates {}

class UserPickedFile extends ElectricityHypothesesStates {}

// Zones States

class GetAllZonesLoadingState extends ElectricityHypothesesStates {}

class GetAllZonesSuccessState extends ElectricityHypothesesStates {}

class GetAllZonesErrorState extends ElectricityHypothesesStates {
  GetAllZonesErrorState(this.message);
  final String message;
}

// Squares States

class GetAllSquaresLoadingState extends ElectricityHypothesesStates {}

class GetAllSquaresSuccessState extends ElectricityHypothesesStates {}

class GetAllSquaresErrorState extends ElectricityHypothesesStates {
  GetAllSquaresErrorState(this.message);
  final String message;
}

// Camps States
class GetAllCampsLoadingState extends ElectricityHypothesesStates {}

class GetAllCampsSuccessState extends ElectricityHypothesesStates {}

class GetAllCampsErrorState extends ElectricityHypothesesStates {
  GetAllCampsErrorState(this.message);
  final String message;
}

// Note Types States
class GetAllNoteTypesLoadingState extends ElectricityHypothesesStates {}

class GetAllNoteTypesSuccessState extends ElectricityHypothesesStates {}

class GetAllNoteTypesErrorState extends ElectricityHypothesesStates {
  GetAllNoteTypesErrorState(this.message);
  final String message;
}

// Note Sub Types States
class GetNoteSubTypesLoadingState extends ElectricityHypothesesStates {}

class GetNoteSubTypesSuccessState extends ElectricityHypothesesStates {}

class GetNoteSubTypesErrorState extends ElectricityHypothesesStates {
  GetNoteSubTypesErrorState(this.message);
  final String message;
}

// Location States
class GetUserLocationLoadingState extends ElectricityHypothesesStates {}

class GetUserLocationSuccessState extends ElectricityHypothesesStates {}

class GetUserLocationErrorState extends ElectricityHypothesesStates {
  GetUserLocationErrorState(this.message);
  final String message;
}

// Add Hypothesis States
class AddWaterHypothesisLoadingState extends ElectricityHypothesesStates {}

class AddWaterHypothesisSuccessState extends ElectricityHypothesesStates {
  AddWaterHypothesisSuccessState(this.message);
  final String message;
}

class AddWaterHypothesisErrorState extends ElectricityHypothesesStates {
  AddWaterHypothesisErrorState(this.message);
  final String message;
}

// Electric Zones States
class GetElectricZonesLoadingState extends ElectricityHypothesesStates {}

class GetElectricZonesSuccessState extends ElectricityHypothesesStates {}

class GetElectricZonesErrorState extends ElectricityHypothesesStates {
  GetElectricZonesErrorState(this.message);
  final String message;
}

// Electric Squares States
class GetElectricSquaresLoadingState extends ElectricityHypothesesStates {}

class GetElectricSquaresSuccessState extends ElectricityHypothesesStates {}

class GetElectricSquaresErrorState extends ElectricityHypothesesStates {
  GetElectricSquaresErrorState(this.message);
  final String message;
}

// Electric Camps States
class GetElectricCampsLoadingState extends ElectricityHypothesesStates {}

class GetElectricCampsSuccessState extends ElectricityHypothesesStates {}

class GetElectricCampsErrorState extends ElectricityHypothesesStates {
  GetElectricCampsErrorState(this.message);
  final String message;
}

// Add Electric Hypothesis States
class AddElectricHypothesisLoadingState extends ElectricityHypothesesStates {}

class AddElectricHypothesisSuccessState extends ElectricityHypothesesStates {
  AddElectricHypothesisSuccessState(this.message);
  final String message;
}

class AddElectricHypothesisErrorState extends ElectricityHypothesesStates {
  AddElectricHypothesisErrorState(this.message);
  final String message;
}
