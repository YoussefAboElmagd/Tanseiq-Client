import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/surveys/presentation/views/widgets/close_dialog_row.dart';

class AttributesDescriptionRow extends StatelessWidget {
  const AttributesDescriptionRow({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: TextStyles.font14SoftBlackBold),
        const Spacer(),
        PopupMenuButton(
          color: ColorsManager.white,
          icon: Icon(size: 30.r, Icons.more_vert, color: ColorsManager.grey),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          position: PopupMenuPosition.under,
          popUpAnimationStyle: AnimationStyle.lerp(
             AnimationStyle(
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 400),
            ),
             AnimationStyle(
              curve: Curves.bounceInOut,
              duration: Duration(milliseconds: 400),
            ),
            5,
          ),
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => PopScope(
                            canPop: true,
                            child: Dialog(
                              insetPadding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 30.h,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                child: const Column(
                                  children: [
                                    CloseDialogRow(title: 'تعديل الحقل'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    );
                  },
                  child: Text('تعديل', style: TextStyles.font16BlackBold),
                ),
                PopupMenuItem(
                  onTap: () {},
                  child: Text('حذف', style: TextStyles.font16RedBold),
                ),
              ],
        ),
      ],
    );
  }
}
