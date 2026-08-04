abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeStatisticsLoadingState extends HomeStates {}

class HomeStatisticsSuccessState extends HomeStates {}

class HomeStatisticsErrorState extends HomeStates {
  final String error;
  HomeStatisticsErrorState(this.error);
}

class HomeMainReportLoadingState extends HomeStates {}

class HomeMainReportSuccessState extends HomeStates {}

class HomeMainReportErrorState extends HomeStates {
  final String error;
  HomeMainReportErrorState(this.error);
}
