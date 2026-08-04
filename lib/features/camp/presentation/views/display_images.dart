import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';

class DisplayImages extends StatelessWidget {
  const DisplayImages({super.key, required this.images});
  final List<File> images;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampCubit, CampStates>(
      builder: (context, state) {
        var cubit = CampCubit.get(context);
        return Scaffold(
          appBar: customAppBar(context: context, title: 'الصور'),
          body:
              images.isEmpty
                  ? const EmptyList(text: 'لا يوجد صور')
                  : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder:
                        (context, index) => Container(
                          margin: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                            top: 10.h,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Stack(
                            // alignment: Alignment.topRight,
                            children: [
                              Image.file(
                                width: double.infinity,
                                height: 300.h,
                                images[index],
                                fit: BoxFit.cover,
                              ),
                              CustomButton(
                                textStyle: TextStyles.font16WhiteBold,
                                color: ColorsManager.red,
                                width: 100.w,
                                title: 'حذف',
                                onTap: () {
                                  cubit.clearImages(images, index);
                                },
                              ),
                            ],
                          ),
                        ),
                    itemCount: images.length,
                  ),
        );
      },
    );
  }
}
