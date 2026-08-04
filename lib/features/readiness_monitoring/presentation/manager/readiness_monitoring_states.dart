abstract class ReadinessMonitoringStates {}

class ReadinessMonitoringInitial extends ReadinessMonitoringStates {}

class GetCampPercentageLoadingState extends ReadinessMonitoringStates {}

class GetCampPercentageSuccessState extends ReadinessMonitoringStates {}

class GetCampPercentageErrorState extends ReadinessMonitoringStates {
  final String error;

  GetCampPercentageErrorState(this.error);
}
