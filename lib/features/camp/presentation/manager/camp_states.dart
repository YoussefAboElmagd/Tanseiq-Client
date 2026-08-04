abstract class CampStates {}

class CampInitial extends CampStates {}

class CampEditPermissionLoadingState extends CampStates {}

class CampEditPermissionState extends CampStates {
  final bool canEdit;
  CampEditPermissionState(this.canEdit);
}

class SelectLocationState extends CampStates {}

class ChangeSupplyState extends CampStates {}

class ChangeStructureState extends CampStates {}

class ClearAllDataState extends CampStates {}

class UserPickedFile extends CampStates {}

class UserCanceled extends CampStates {}

class NoNewFilesAdded extends CampStates {}

class ChangePrepareTintItem extends CampStates {}

class GetAllCampLoading extends CampStates {}

class GetAllCampSuccess extends CampStates {}

class GetAllCampError extends CampStates {
  final String message;
  GetAllCampError(this.message);
}

class GetAllSquaresLoading extends CampStates {}

class GetAllSquaresSuccess extends CampStates {}

class GetAllSquaresError extends CampStates {
  final String message;
  GetAllSquaresError(this.message);
}

class GetCampByIdLoading extends CampStates {}

class GetCampByIdSuccess extends CampStates {}

class GetCampByIdError extends CampStates {
  final String message;
  GetCampByIdError(this.message);
}

class PostRequestCampLoading extends CampStates {}

class PostRequestCampSuccess extends CampStates {}

class PostRequestCampError extends CampStates {
  final String message;
  PostRequestCampError(this.message);
}

class GetAllTentsLoading extends CampStates {}

class GetAllTentsSuccess extends CampStates {}

class GetAllTentsError extends CampStates {
  final String error;
  GetAllTentsError(this.error);
}

class GetAllTentsPaginationLoading extends CampStates {}

class GetAllTentsPaginationSuccess extends CampStates {}

class GetAllTentsPaginationError extends CampStates {
  final String error;
  GetAllTentsPaginationError(this.error);
}

class GetCampDetailsLoading extends CampStates {}

class GetCampDetailsSuccess extends CampStates {}

class GetCampDetailsError extends CampStates {
  final String error;
  GetCampDetailsError(this.error);
}

class StatisticsLoadingState extends CampStates {}

class StatisticsSuccessState extends CampStates {}

class StatisticsErrorState extends CampStates {
  final String error;
  StatisticsErrorState(this.error);
}

class GetPreparingCampServicesLoading extends CampStates {}

class GetPreparingCampServicesSuccess extends CampStates {}

class GetPreparingCampServicesError extends CampStates {
  final String error;
  GetPreparingCampServicesError(this.error);
}

class GetStatusDropdownLoading extends CampStates {}

class GetStatusDropdownSuccess extends CampStates {}

class GetStatusDropdownError extends CampStates {
  final String error;
  GetStatusDropdownError(this.error);
}

class GetCampBuildingWorkLoading extends CampStates {}

class GetCampBuildingWorkSuccess extends CampStates {}

class GetCampBuildingWorkError extends CampStates {
  final String error;
  GetCampBuildingWorkError(this.error);
}

class GetCampPreparingWorkLoading extends CampStates {}

class GetCampPreparingWorkSuccess extends CampStates {}

class GetCampPreparingWorkError extends CampStates {
  final String error;
  GetCampPreparingWorkError(this.error);
}

class PostPreparingTentLoadingState extends CampStates {}

class PostPreparingTentSuccessState extends CampStates {}

class PostPreparingTentErrorState extends CampStates {
  final String error;
  PostPreparingTentErrorState(this.error);
}

class UpdateScoreMinaLoadingState extends CampStates {}

class UpdateScoreMinaSuccessState extends CampStates {}

class UpdateScoreMinaErrorState extends CampStates {
  final String error;
  UpdateScoreMinaErrorState(this.error);
}

class GetDropDownFilterLoadingState extends CampStates {}

class GetDropDownFilterSuccessState extends CampStates {}

class GetDropDownFilterErrorState extends CampStates {
  final String error;
  GetDropDownFilterErrorState(this.error);
}

class GetCampPercentageLoadingState extends CampStates {}

class GetCampPercentageSuccessState extends CampStates {}

class GetCampPercentageErrorState extends CampStates {
  final String error;
  GetCampPercentageErrorState(this.error);
}

class GetZonesLoadingState extends CampStates {}

class GetZonesSuccessState extends CampStates {}

class GetZonesErrorState extends CampStates {
  final String error;
  GetZonesErrorState(this.error);
}
