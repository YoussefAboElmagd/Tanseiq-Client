import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/features/asset_rentail/data/models/get_all_assets_response.dart';
import 'package:tanseiq/features/asset_rentail/data/repos/assets_rentail_repo.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_states.dart';
import 'package:tanseiq/features/camp/data/models/get_drop_down_filter_response.dart';
import 'package:tanseiq/features/complains/data/models/get_all_camps.dart';

class AssetRentailCubit extends Cubit<AssetRentailStates> {
  AssetRentailCubit(this.assetsRentailRepo) : super(AssetRentailInitial());
  final AssetsRentailRepo assetsRentailRepo;
  static AssetRentailCubit get(context) => BlocProvider.of(context);

  int selectRegion = -1;

  void setSelectRegion(int index) {
    selectRegion = index;
    emit(ChangeIndex());
  }

  int selectRequestType = 0;
  void changeIndex(int index) {
    selectRequestType = index;
    emit(ChangeIndexState());
  }

  List<GetAllCamps> campNumbers = [];
  String campNumberId = '';
  String campNumber = '';
  Future emitGetAllCampNumber() async {
    campNumbers.clear();
    emit(GetAllCampNumberLoadingState());
    final response = await assetsRentailRepo.getAllCampNumber();
    response.when(
      success: (data) {
        campNumbers.addAll(data);
        emit(GetAllCampNumberSuccessState());
      },
      failure: (error) {
        emit(GetAllCampNumberErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetDropDownFilterResponse> rentailCompany = [];
  String rentailCompanyId = '';
  Future emitGetRentailCompany() async {
    rentailCompany.clear();
    emit(GetRentailCompanyLoadingState());
    final response = await assetsRentailRepo.getRentailCompany();
    response.when(
      success: (data) {
        rentailCompany.addAll(data);
        emit(GetRentailCompanySuccessState());
      },
      failure: (error) {
        emit(GetRentailCompanyErrorState(error.failure.message ?? ''));
      },
    );
  }

  List<GetDropDownFilterResponse> developerCompany = [];
  String developerCompanyId = '';
  Future emitGetDeveloperCompany() async {
    developerCompany.clear();
    emit(GetDeveloperCompanyLoadingState());
    final response = await assetsRentailRepo.getDropDownDeveloper();
    response.when(
      success: (data) {
        developerCompany.addAll(data);
        emit(GetDeveloperCompanySuccessState());
      },
      failure: (error) {
        emit(GetDeveloperCompanyErrorState(error.failure.message ?? ''));
      },
    );
  }

  bool hasNext = true;
  int page = 0;
  List<GetAllAssetsResponseData> rejectedAssets = [];
  Future emitGetRejectedAssets() async {
    hasNext = true;
    rejectedAssets.clear();
    emit(GetAllRejectedAssetsLoadingState());
    final response = await assetsRentailRepo.getRejectedAssets(
      campNumber: campNumber,
      developerId: developerCompanyId,
      companyId: rentailCompanyId,
      page: page,
    );
    response.when(
      success: (data) {
        rejectedAssets.addAll(data.data);
        emit(GetAllRejectedAssetsSuccessState());
      },
      failure: (error) {
        emit(GetAllRejectedAssetsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetPaginatedRejectedAssets() async {
    emit(GetAllRejectedAssetsPaginatedLoadingState());
    final response = await assetsRentailRepo.getRejectedAssets(
      campNumber: campNumber,
      developerId: developerCompanyId,
      companyId: rentailCompanyId,
      page: page,
    );
    int length = rejectedAssets.length;
    response.when(
      success: (data) {
        page = data.currentPage!;
        rejectedAssets.addAll(data.data);
        if (rejectedAssets.length > length) {
          hasNext = true;
        } else {
          hasNext = false;
        }
        emit(GetAllRejectedAssetsPaginatedSuccessState());
      },
      failure: (error) {
        emit(
          GetAllRejectedAssetsPaginatedErrorState(error.failure.message ?? ''),
        );
      },
    );
  }

  List<GetAllAssetsResponseData> allAssets = [];
  Future emitGetAllAssets() async {
    hasNext = true;
    allAssets.clear();
    emit(GetAllAssetsLoadingState());
    final response = await assetsRentailRepo.getAllAssets(
      campNumber: campNumber,
      developerId: developerCompanyId,
      companyId: rentailCompanyId,
      page: page,
    );
    response.when(
      success: (data) {
        allAssets.addAll(data.data);
        emit(GetAllAssetsSuccessState());
      },
      failure: (error) {
        emit(GetAllAssetsErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitGetPaginatedAllAssets() async {
    emit(GetAllAssetsPaginatedLoadingState());
    print('camp Number $campNumber');
    print('developer Company Id $developerCompanyId');
    print('rentail CompanyId $rentailCompanyId');
    print('page $page');
    final response = await assetsRentailRepo.getAllAssets(
      campNumber: campNumber,
      developerId: developerCompanyId,
      companyId: rentailCompanyId,
      page: page,
    );
    int length = allAssets.length;
    response.when(
      success: (data) {
        page = data.currentPage!;
        allAssets.addAll(data.data);
        if (allAssets.length > length) {
          hasNext = true;
        } else {
          hasNext = false;
        }
        emit(GetAllAssetsPaginatedSuccessState());
      },
      failure: (error) {
        emit(GetAllAssetsPaginatedErrorState(error.failure.message ?? ''));
      },
    );
  }

  Future emitAssetsRentailMethod() async {
    await emitGetRentailCompany();
    // await emitGetDeveloperCompany();
    await emitGetAllCampNumber();
    await emitGetAllAssets();
  }

  void emitClearAll() {
    rejectedAssets.clear();
    allAssets.clear();
    campNumber = '';
    developerCompanyId = '';
    rentailCompanyId = '';
    page = 0;
    campNumberId = '';
    emit(ClearAll());
  }
}
