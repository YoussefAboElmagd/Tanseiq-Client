import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/features/camp/data/models/get_camp_analysis_reponse.dart';
import 'package:tanseiq/features/readiness_monitoring/data/repos/readiness_repo.dart';
import 'package:tanseiq/features/readiness_monitoring/presentation/manager/readiness_monitoring_states.dart';

class ReadinessMonitoringCubit extends Cubit<ReadinessMonitoringStates> {
  ReadinessMonitoringCubit(this.readinessRepo)
    : super(ReadinessMonitoringInitial());
  ReadinessRepo readinessRepo;

  static ReadinessMonitoringCubit get(context) => BlocProvider.of(context);

  List<GetCampAnalysisReponse> campAanalysis = [];
  Future emitGetCampPercentage() async {
    campAanalysis.clear();
    emit(GetCampPercentageLoadingState());
    final response = await readinessRepo.getCampPercentage(
      0,
      0,
      0,
      Constant.startDate,
    );
    response.when(
      success: (success) {
        campAanalysis.addAll(success);
        emit(GetCampPercentageSuccessState());
      },
      failure: (error) {
        emit(GetCampPercentageErrorState(error.failure.message ?? ''));
      },
    );
  }
}
