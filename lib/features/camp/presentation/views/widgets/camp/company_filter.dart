import 'package:flutter/material.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';

class CompanyFilter extends StatelessWidget {
  const CompanyFilter({super.key, required this.cubit, this.customZone});
  final String? customZone;
  final CampCubit cubit;

  @override
  Widget build(BuildContext context) {
    return DropDownListById(
      text: 'اختر الشركة',
      list: cubit.filterList,
      selectedValue: cubit.companyId,
      onChanged: (value, text) async {
        cubit.companyId = value;
        cubit.campNumber = null;
        await cubit.emitGetAllTents(
          companyId: cubit.companyId,
          zone:
              customZone ??
              (cubit.currentIndexTabBar == 0
                  ? null
                  : cubit.currentIndexTabBar == 1
                  ? 'مني'
                  : cubit.currentIndexTabBar == 2
                  ? 'عرفات'
                  : 'المزدلفة'),
        );
      },
    );
  }
}
