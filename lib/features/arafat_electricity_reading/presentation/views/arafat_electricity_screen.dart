import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/snack_bar_error_handling.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/manager/arafat_electricity_cubit.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/manager/arafat_electricity_states.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/views/widgets/access_restricted_widget.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/views/widgets/image_upload_card.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/views/widgets/period_selector.dart';
import 'package:tanseiq/features/arafat_electricity_reading/presentation/views/widgets/ryb_reading_card.dart';

class ArafatElectricityScreen extends StatefulWidget {
  const ArafatElectricityScreen({super.key});

  @override
  State<ArafatElectricityScreen> createState() =>
      _ArafatElectricityScreenState();
}

class _ArafatElectricityScreenState extends State<ArafatElectricityScreen> {
  @override
  void initState() {
    super.initState();
    ArafatElectricityCubit.get(context).emitGetGeneratorsSerials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocConsumer<ArafatElectricityCubit, ArafatElectricityStates>(
        listener: (context, state) {
          if (state is SaveArafatReadingLoadingState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else if (state is SaveArafatReadingSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                message: 'تم حفظ القراءة بنجاح',
                color: ColorsManager.green,
              ),
            );
            context.pop();
          } else if (state is SaveArafatReadingErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                message: state.message,
                color: ColorsManager.darkRed,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = ArafatElectricityCubit.get(context);
          if (state is ArafatAccessRestrictedState) {
            return const AccessRestrictedWidget();
          }
          if (state is GetGeneratorsSerialsLoadingState) {
            return circular;
          }
          if (state is GetGeneratorsSerialsErrorState) {
            return EmptyList(
              text: 'يوجد مشكلة في جلب البيانات',
              onRefresh: () async => cubit.emitGetGeneratorsSerials(),
              imageColor: ColorsManager.darkRed,
            );
          }
          return Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                spacing: 16.h,
                children: [
                  PeriodSelector(cubit: cubit),
                  _DateTimeDisplay(),
                  RybReadingCard(cubit: cubit),
                  ImageUploadCard(cubit: cubit),
                  SizedBox(height: 60.h),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:
          BlocBuilder<ArafatElectricityCubit, ArafatElectricityStates>(
            builder: (context, state) {
              final cubit = ArafatElectricityCubit.get(context);
              if (state is ArafatAccessRestrictedState ||
                  state is SaveArafatReadingLoadingState) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: CustomButton(
                  borderRadius: 12.r,
                  title: 'حفظ القراءة',
                  textStyle: TextStyles.font16WhiteBold,
                  onTap: () => cubit.emitSaveReading(context),
                ),
              );
            },
          ),
    );
  }

  AppBar _buildAppBar() => AppBar(
    leading: const ArrowBack(),
    titleSpacing: 0,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('إضافة قراءة جديدة', style: TextStyles.font16BlackBold),
        Text(
          'تسجيل بيانات المحول الكهربائي',
          style: TextStyles.font12NormalGrey,
        ),
      ],
    ),
    actions: [
      Container(
        margin: EdgeInsets.only(right: 12.w, top: 8.h, bottom: 8.h, left: 8.w),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: ColorsManager.mainColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(Icons.bolt, color: ColorsManager.white, size: 20.r),
      ),
    ],
  );
}

class _DateTimeDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date = '${now.year}/${now.month}/${now.day}، ${_formatTime(now)}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: 14.r,
          color: ColorsManager.grey,
        ),
        SizedBox(width: 6.w),
        Text(date, style: TextStyles.font12NormalGrey),
      ],
    );
  }

  String _formatTime(DateTime dt) {
    final h =
        dt.hour > 12
            ? dt.hour - 12
            : dt.hour == 0
            ? 12
            : dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'م' : 'ص';
    return '$h:$m:$s $period';
  }
}
