import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tanseiq/features/readiness_license/presentation/cubit/readiness_license_state.dart';

class ReadinessLicenseCubit extends Cubit<ReadinessLicenseState> {
  ReadinessLicenseCubit() : super(ReadinessLicenseInitialState());
  static ReadinessLicenseCubit get(context) => BlocProvider.of(context);
}
