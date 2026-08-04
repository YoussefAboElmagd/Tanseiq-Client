import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
// import 'package:tanseiq/core/theming/assets.dart';
// import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
// import 'package:tanseiq/features/home/presentation/views/widgets/home_item_design.dart';
// import 'package:tanseiq/features/home/presentation/views/widgets/home_row_descrip_design.dart';

class RentailFollow extends StatelessWidget {
  const RentailFollow({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'مساحات المؤجرة :  ',
      'المناطق المرفوضة :',
      'المناطق المؤجرة:',
    ];
    List<String> items2 = ['2600متر مربع', '100', '300'];
    return Column(
      children: [
        // const HomeRowDescripDesign(
        //   title: 'متابعة التاجير',
        //   image: Assets.assetsImagesContracts,
        // ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: CustomButton(
            borderRadius: 16.r,
            textStyle: TextStyles.font16WhiteBold,
            title: 'متابعة التأجير',
            onTap: () {
              // context.read<UiCubit>().emitCheckRoute(
              //   route: Routes.assetRentail,
              //   context: context,
              // );
              context.pushNamed(Routes.assetRentail);
            },
          ),
        ),
        // HomeItemDesign(
        //   height: 220.h,
        //   onTap: () {
        //     context.read<UiCubit>().emitCheckRoute(
        //       route: Routes.assetRentail,
        //       context: context,
        //     );
        //     // context.pushNamed(Routes.trackRentail);
        //   },
        //   widget: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        //     child: ListView.builder(
        //       itemBuilder:
        //           (context, index) => Container(
        //             width: double.infinity,
        //             height: 50.h,
        //             margin: EdgeInsets.only(bottom: 10.h),
        //             padding: EdgeInsets.symmetric(horizontal: 10.w),
        //             decoration: BoxDecoration(
        //               border: Border.all(color: ColorsManager.mainColor),
        //               color: ColorsManager.soft2MainColor,
        //               borderRadius: BorderRadius.circular(10.r),
        //             ),
        //             child: Row(
        //               children: [
        //                 Text(
        //                   items[index],
        //                   style: TextStyles.font14MainColorBold,
        //                 ),
        //                 const Spacer(),
        //                 Text(items2[index], style: TextStyles.font14BlackBold),
        //               ],
        //             ),
        //           ),
        //       itemCount: 3,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
