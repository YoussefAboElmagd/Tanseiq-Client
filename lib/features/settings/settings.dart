import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/widgets/custom_app_bar_slivers.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/auth/presentation/views/logout_alert.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const CustomAppBarSlivers(tilte: 'الاعدادات'),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  CustomButton(
                    color: ColorsManager.darkRed,
                    title: 'تسجيل الخروج',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const LogoutAlert(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
