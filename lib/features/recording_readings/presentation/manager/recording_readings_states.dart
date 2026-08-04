abstract class RecordingReadingsStates {}

class RecordingReadingsInitial extends RecordingReadingsStates {}

class ClearAllDataState extends RecordingReadingsStates {}

class UserCanceled extends RecordingReadingsStates {}

class NoNewFilesAdded extends RecordingReadingsStates {}

class UserPickedFile extends RecordingReadingsStates {}

class GetZonesLoadingState extends RecordingReadingsStates {}

class GetZonesSuccessState extends RecordingReadingsStates {}

class GetZonesErrorState extends RecordingReadingsStates {
  final String message;
  GetZonesErrorState(this.message);
}

class SaveReadingLoadingState extends RecordingReadingsStates {}

class SaveReadingSuccessState extends RecordingReadingsStates {}

class SaveReadingErrorState extends RecordingReadingsStates {
  final String message;
  SaveReadingErrorState(this.message);
}

class GetDropDownFilterLoadingState extends RecordingReadingsStates {}

class GetDropDownFilterSuccessState extends RecordingReadingsStates {}

class GetDropDownFilterErrorState extends RecordingReadingsStates {
  final String message;
  GetDropDownFilterErrorState(this.message);
}

class GetDeveloperCompanyLoadingState extends RecordingReadingsStates {}

class GetDeveloperCompanySuccessState extends RecordingReadingsStates {}

class GetDeveloperCompanyErrorState extends RecordingReadingsStates {
  final String message;
  GetDeveloperCompanyErrorState(this.message);
}

class GetGeneratorsSerialsLoadingState extends RecordingReadingsStates {}

class GetGeneratorsSerialsSuccessState extends RecordingReadingsStates {}

class GetGeneratorsSerialsErrorState extends RecordingReadingsStates {
  final String message;
  GetGeneratorsSerialsErrorState(this.message);
}

class GetMapPointsLoadingState extends RecordingReadingsStates {}

class GetMapPointsSuccessState extends RecordingReadingsStates {}

class GetMapPointsErrorState extends RecordingReadingsStates {
  final String message;
  GetMapPointsErrorState(this.message);
}

class GetAllGeneratorsLoadingState extends RecordingReadingsStates {}

class GetAllGeneratorsSuccessState extends RecordingReadingsStates {}

class GetAllGeneratorsErrorState extends RecordingReadingsStates {
  final String message;
  GetAllGeneratorsErrorState(this.message);
}

class GetAllGeneratorsPaginationLoadingState extends RecordingReadingsStates {}

class GetAllGeneratorsPaginationSuccessState extends RecordingReadingsStates {}

class GetAllGeneratorsPaginationErrorState extends RecordingReadingsStates {
  final String message;
  GetAllGeneratorsPaginationErrorState(this.message);
}

class GetGeneratorsReadingLoadingState extends RecordingReadingsStates {}

class GetGeneratorsReadingSuccessState extends RecordingReadingsStates {}

class GetGeneratorsReadingErrorState extends RecordingReadingsStates {
  final String message;
  GetGeneratorsReadingErrorState(this.message);
}
