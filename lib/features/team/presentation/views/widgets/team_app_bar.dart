import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/team/presentation/views/widgets/export_and_import_buttons_desing.dart';

class TeamAppBar extends StatelessWidget {
  const TeamAppBar({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 160.h,
      actions: [
        IconButton(
          icon: Image.asset(
            Assets.assetsImagesNotification,
            width: 26.w,
            height: 26.h,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset(
            Assets.assetsImagesArrowBackEN,
            width: 20.w,
            height: 20.h,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ],
      floating: true,
      pinned: false,
      title: Text('فرق العمل', style: TextStyles.font20MainColorBold),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Row(
                children: [
                  const ExportAndImportButtonsDesign(
                    image: Assets.assetsImagesImport,
                    title: 'تصدير',
                  ),
                  20.width,
                  const ExportAndImportButtonsDesign(
                    image: Assets.assetsImagesExport,
                    title: 'استيراد',
                  ),
                ],
              ),
              10.height,
              CustomButton(title: '+إضافة عضو', onTap: onTap),
            ],
          ),
        ),
      ),
    );
  }
}
