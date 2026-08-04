import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';

class PickImageRow extends StatelessWidget {
  const PickImageRow({super.key, required this.cubit});

  final ComplainsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        cubit.images.isEmpty
            ? const SizedBox.shrink()
            : Expanded(
              child: CustomButton(
                height: 55.h,
                color: ColorsManager.mainColor,
                textStyle: TextStyles.font16WhiteBold,
                title: 'عرض الصور',
                onTap: () {
                  context.pushNamed(
                    Routes.displayImages,
                    arguments: {'images': cubit.images},
                  );
                },
              ),
            ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              cubit.emitPickImage(context: context);
            },
            child: Image.asset(Assets.assetsImagesAddImage2),
          ),
        ),
      ],
    );
  }
}
