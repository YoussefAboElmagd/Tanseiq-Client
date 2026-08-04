import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar_slivers.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/team/presentation/views/widgets/team_user_attributes.dart';

class UserTeamDetails extends StatelessWidget {
  const UserTeamDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: CustomScrollView(
        slivers: [
          const CustomAppBarSlivers(tilte: 'فرق العمل', displayArrow: true),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.height,
                  Container(
                    width: 70.w,
                    height: 70.h,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.soft3Grey,
                    ),
                    child: Image.asset(
                      Assets.assetsImagesProfile,
                      color: ColorsManager.grey,
                      width: 40.w,
                    ),
                  ),
                  20.height,
                  const TeamUserAttributes(),
                  20.height,
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          color: ColorsManager.green,
                          textStyle: TextStyles.font16WhiteBold,
                          borderRadius: 10.r,
                          title: 'حفظ التغييرات',
                          onTap: () {},
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: CustomButton(
                          borderColor: ColorsManager.darkRed,
                          borderRadius: 10.r,
                          title: 'حذف',
                          textStyle: TextStyles.font16DarkRedBold,
                          color: ColorsManager.white,
                          onTap: () {},
                        ),
                      ),
                    ],
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
