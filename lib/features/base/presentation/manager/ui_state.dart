abstract class UiState {}

class Initial extends UiState {}

class ChangeLanguage extends UiState {}

class ChangeBottomNav extends UiState {}

class ToggleBottomNavBar extends UiState {}

class CheckRouteLoading extends UiState {}

class CheckRouteSuccess extends UiState {}

class CheckRouteError extends UiState {
  String error;
  CheckRouteError(this.error);
}
