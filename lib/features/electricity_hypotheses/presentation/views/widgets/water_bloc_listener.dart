import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:tanseiq/core/helpers/extentions.dart';
// import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_cubit.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_states.dart';

class WaterBlocListener extends StatelessWidget {
  const WaterBlocListener({super.key});

  void _showLocationDialog(BuildContext context, String message) {
    final bool isPermissionDenied = message.contains('permissions');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Row(
                children: [
                  Icon(Icons.location_off, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    'الموقع غير متاح',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Text(
                isPermissionDenied
                    ? 'لم يتم منح إذن الوصول للموقع. يرجى تفعيله من إعدادات التطبيق.'
                    : 'خدمة الموقع (GPS) معطلة. يرجى تفعيلها للمتابعة.',
                textAlign: TextAlign.right,
              ),
              actionsAlignment: MainAxisAlignment.start,
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text(
                    'إلغاء',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.mainColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.settings, size: 18),
                  label: Text(
                    isPermissionDenied ? 'فتح الإعدادات' : 'تفعيل GPS',
                  ),
                  onPressed: () async {
                    Navigator.of(ctx).pop();
                    if (isPermissionDenied) {
                      await permission.openAppSettings();
                    } else {
                      await Location().requestService();
                    }
                    // Retry getting location after the user acts
                    if (context.mounted) {
                      await context
                          .read<ElectricityHypothesesCubit>()
                          .emitGetUserLocation();
                    }
                  },
                ),
              ],
            ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      ElectricityHypothesesCubit,
      ElectricityHypothesesStates
    >(
      listener: (context, state) {
        if (state is GetUserLocationErrorState) {
          _showLocationDialog(context, state.message);
        }
        if (state is AddWaterHypothesisLoadingState ||
            state is AddElectricHypothesisLoadingState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showDialog(
              context: context,
              builder: (context) => PopScope(canPop: false, child: circular),
            );
          });
        }
        if (state is AddWaterHypothesisSuccessState ||
            state is AddElectricHypothesisSuccessState) {
          context.popAlert();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              message: 'تم ارسال الفرضية بنجاح',
              color: Colors.green,
            ),
          );
          context.pop();
        }
        if (state is AddWaterHypothesisErrorState) {
          // state.isBack ? context.popAlert() : null;
          context.popAlert();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(message: state.message, color: ColorsManager.red),
          );
        }
        if (state is AddElectricHypothesisErrorState) {
          context.popAlert();
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(message: state.message, color: ColorsManager.red),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
