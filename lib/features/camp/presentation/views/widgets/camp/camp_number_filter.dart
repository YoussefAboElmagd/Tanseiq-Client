import 'package:flutter/material.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/drop_down_list_by_id.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';

class CampNumberFilter extends StatelessWidget {
  const CampNumberFilter({super.key, required this.cubit, required this.state});

  final CampCubit cubit;
  final CampStates state;

  @override
  Widget build(BuildContext context) {
    return cubit.campNumbers.isEmpty
        ? cubit.campNumber == null
            ? Text(
              'لا يوجد مخيمات للبحث عنها',
              style: TextStyles.font14BlackBold,
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cubit.campNumber ?? 'لا يوجد مخيمات للبحث عنها',
                  style: TextStyles.font14BlackBold,
                ),
                state is GetAllTentsLoading || cubit.campNumbers.isEmpty
                    ? const SizedBox.shrink()
                    : const Spacer(),
                state is GetAllTentsLoading
                    ? const SizedBox.shrink()
                    : TextButton(
                      onPressed: () async {
                        cubit.campNumber = null;
                        await cubit.emitGetAllTents(
                          companyId: cubit.companyId,
                          zone:
                              cubit.currentIndexTabBar == 0
                                  ? null
                                  : cubit.currentIndexTabBar == 1
                                  ? 'مني'
                                  : cubit.currentIndexTabBar == 2
                                  ? 'عرفات'
                                  : 'المزدلفة',
                        );
                      },
                      child: Text('مسح', style: TextStyles.font14RedBold),
                    ),
              ],
            )
        : DropDownList(
          text: 'اختر رقم مخيم',
          list: cubit.campNumbers,
          selectedValue: cubit.campNumber,
          onChanged: (value) async {
            cubit.campNumber = value;
            await cubit.emitGetAllTents(
              companyId: cubit.companyId,
              campNumber: cubit.campNumber,
              zone:
                  cubit.currentIndexTabBar == 0
                      ? null
                      : cubit.currentIndexTabBar == 1
                      ? 'مني'
                      : cubit.currentIndexTabBar == 2
                      ? 'عرفات'
                      : 'المزدلفة',
            );
          },
        );
  }
}
