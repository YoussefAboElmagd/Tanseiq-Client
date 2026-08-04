abstract class AssetRentailStates {}

class AssetRentailInitial extends AssetRentailStates {}

class ClearAll extends AssetRentailStates {}

class ChangeIndexState extends AssetRentailStates {}

class ChangeIndex extends AssetRentailStates {}

class GetAllCampNumberLoadingState extends AssetRentailStates {}

class GetAllCampNumberSuccessState extends AssetRentailStates {}

class GetAllCampNumberErrorState extends AssetRentailStates {
  final String message;
  GetAllCampNumberErrorState(this.message);
}

class GetRentailCompanyLoadingState extends AssetRentailStates {}

class GetRentailCompanySuccessState extends AssetRentailStates {}

class GetRentailCompanyErrorState extends AssetRentailStates {
  final String message;
  GetRentailCompanyErrorState(this.message);
}

class GetDeveloperCompanyLoadingState extends AssetRentailStates {}

class GetDeveloperCompanySuccessState extends AssetRentailStates {}

class GetDeveloperCompanyErrorState extends AssetRentailStates {
  final String message;
  GetDeveloperCompanyErrorState(this.message);
}

class GetAllRejectedAssetsLoadingState extends AssetRentailStates {}

class GetAllRejectedAssetsSuccessState extends AssetRentailStates {}

class GetAllRejectedAssetsErrorState extends AssetRentailStates {
  final String message;
  GetAllRejectedAssetsErrorState(this.message);
}

class GetAllRejectedAssetsPaginatedLoadingState extends AssetRentailStates {}

class GetAllRejectedAssetsPaginatedSuccessState extends AssetRentailStates {}

class GetAllRejectedAssetsPaginatedErrorState extends AssetRentailStates {
  final String message;
  GetAllRejectedAssetsPaginatedErrorState(this.message);
}

class GetAllAssetsLoadingState extends AssetRentailStates {}

class GetAllAssetsSuccessState extends AssetRentailStates {}

class GetAllAssetsErrorState extends AssetRentailStates {
  final String message;
  GetAllAssetsErrorState(this.message);
}

class GetAllAssetsPaginatedLoadingState extends AssetRentailStates {}

class GetAllAssetsPaginatedSuccessState extends AssetRentailStates {}

class GetAllAssetsPaginatedErrorState extends AssetRentailStates {
  final String message;
  GetAllAssetsPaginatedErrorState(this.message);
}
