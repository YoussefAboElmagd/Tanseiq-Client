abstract class SupportStates {}

class SupportInitial extends SupportStates {}

class UserPickedFile extends SupportStates {}

class UserCanceled extends SupportStates {}

class NoNewFilesAdded extends SupportStates {}

class UploadLoadingSupportState extends SupportStates {}

class UploadSuccessSupportState extends SupportStates {}

class UploadErrorSupportState extends SupportStates {
  final String? error;

  UploadErrorSupportState(this.error);
}
