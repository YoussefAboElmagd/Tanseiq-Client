import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_cubit.dart';
import 'package:tanseiq/features/auth/presentation/manager/auth_states.dart';
import 'package:tanseiq/features/auth/presentation/views/widgets/auth_component.dart';
import 'package:tanseiq/features/auth/presentation/views/widgets/bloc_listener/otp_bloc_listener.dart';

class OTP extends StatefulWidget {
  const OTP({
    super.key,
    required this.isFromLogin,
    required this.isFromRecover,
    required this.email,
  });
  final bool isFromLogin;
  final bool isFromRecover;
  final String email;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  static const _otpLength = 4;

  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool get _isComplete => _otpController.text.length == _otpLength;

  @override
  void initState() {
    super.initState();
    _otpController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _submitOtp(AuthCubit cubit) {
    if (_formKey.currentState!.validate()) {
      cubit.emitVerifyOtp(email: widget.email, otp: _otpController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        final cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(leading: const ArrowBack()),
          body: AuthComponent(
            height: 450.h,
            title: 'OTP',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _OtpPinField(
                      controller: _otpController,
                      length: _otpLength,
                      validator: (val) =>
                          (val == null || val.length < _otpLength) ? '' : null,
                      onCompleted: (_) => _submitOtp(cubit),
                    ),
                    15.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          ),
                          onPressed: cubit.canResend
                              ? () => cubit.emitSentOtp(email: widget.email)
                              : null,
                          child: Text(
                            cubit.canResend
                                ? 'ارسال الرمز'
                                : 'ارسال مرة اخري بعد:',
                            style: cubit.canResend
                                ? TextStyles.font14GreenBold
                                : TextStyles.font14DarkGrey,
                          ),
                        ),
                        if (cubit.remainingSeconds > 0 &&
                            cubit.remainingSeconds != 30)
                          Text(
                            '${cubit.remainingSeconds}',
                            style: TextStyles.font14DarkGrey,
                          ),
                      ],
                    ),
                    20.height,
                    CustomButton(
                      title: 'تأكيد',
                      onTap: () => _submitOtp(cubit),
                    ),
                    OtpBlocListener(
                      email: widget.email,
                      isFromLogin: widget.isFromLogin,
                      isFromRecover: widget.isFromRecover,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Pinput-based OTP input field styled to Tanseiq's design system.
class _OtpPinField extends StatelessWidget {
  const _OtpPinField({
    required this.controller,
    required this.length,
    this.onCompleted,
    this.validator,
  });

  final TextEditingController controller;
  final int length;
  final ValueChanged<String>? onCompleted;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final gutters = 10.w * (length - 1);
    final margins = 40.w;
    final cellWidth = (1.sw - margins - gutters) / length;
    final cellHeight = cellWidth * 1.4;

    PinTheme cell({required Color border, required Color fill}) => PinTheme(
          width: cellWidth,
          height: cellHeight,
          textStyle: TextStyles.font20SoftBlackBold,
          decoration: BoxDecoration(
            color: fill,
            border: Border.all(color: border, width: 1.3),
            borderRadius: BorderRadius.circular(16.r),
          ),
        );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: length,
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: onCompleted,
        validator: validator,
        separatorBuilder: (_) => SizedBox(width: 10.w),
        defaultPinTheme: cell(
          border: ColorsManager.grey.withValues(alpha: 0.7),
          fill: ColorsManager.white,
        ),
        focusedPinTheme: cell(
          border: ColorsManager.mainColor,
          fill: ColorsManager.white,
        ),
        submittedPinTheme: cell(
          border: ColorsManager.mainColor,
          fill: ColorsManager.softMainColor,
        ),
        errorPinTheme: cell(
          border: ColorsManager.red,
          fill: ColorsManager.softRed,
        ),
      ),
    );
  }
}
