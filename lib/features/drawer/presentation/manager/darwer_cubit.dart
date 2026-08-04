import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/features/drawer/presentation/manager/drawer_states.dart';

class DarwerCubit extends Cubit<DrawerState> {
  DarwerCubit() : super(DrawerInitial());

  static DarwerCubit get(context) => BlocProvider.of(context);

  int selectedItem = -1;
  void changeDrawerItem(int index) {
    selectedItem = index;
    emit(ChangeDarwerItem());
  }
}
