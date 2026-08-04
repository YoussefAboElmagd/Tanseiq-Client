import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/features/home/data/models/get_home_statistics_response.dart';
import 'package:tanseiq/features/home/data/models/main_report.dart';
import 'package:tanseiq/features/home/data/repos/home_repo.dart';
import 'package:tanseiq/features/home/presentation/manager/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeRepo) : super(HomeInitialState());
  final HomeRepo homeRepo;
  static HomeCubit get(context) => BlocProvider.of(context);

  Future emitGetAllHome() async {
    await emitGetHomeStatistics();
    await emitGetMainReport();
  }

  late GetHomeStatisticsResponse homeStatistics;
  Future emitGetHomeStatistics() async {
    emit(HomeStatisticsLoadingState());
    final response = await homeRepo.getHomeStatistics();
    response.when(
      success: (success) {
        homeStatistics = success;
        emit(HomeStatisticsSuccessState());
      },
      failure: (error) {
        emit(HomeStatisticsErrorState(error.failure.message ?? ''));
      },
    );
  }

  late List<MainReport> mainReport;
  Future emitGetMainReport() async {
    emit(HomeMainReportLoadingState());
    final response = await homeRepo.getStatusProblem();
    print('response $response');
    response.when(
      success: (success) {
        mainReport = success;
        emit(HomeMainReportSuccessState());
      },
      failure: (error) {
        // print(error.failure.message);
        // print(error.failure.code);
        // print(error);
        emit(HomeMainReportErrorState(error.failure.message ?? ''));
      },
    );
  }
}
