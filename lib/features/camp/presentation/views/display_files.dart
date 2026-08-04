import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';

class DisplayFiles extends StatelessWidget {
  const DisplayFiles({super.key, required this.files});
  final List<File> files;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampCubit, CampStates>(
      builder: (context, state) {
        var cubit = CampCubit.get(context);
        return Scaffold(
          appBar: customAppBar(context: context, title: 'الملفات'),
          body:
              files.isEmpty
                  ? const EmptyList(text: 'لا يوجد ملفات')
                  : ListView.builder(
                    itemBuilder:
                        (context, index) => Padding(
                          padding: EdgeInsets.only(
                            right: 20.w,
                            left: 20.w,
                            top: 10.h,
                          ),
                          child: Row(
                            children: [
                              CustomButton(
                                textStyle: TextStyles.font16WhiteBold,
                                color: ColorsManager.red,
                                width: 100.w,
                                title: 'حذف',
                                borderRadius: 16.r,
                                onTap: () {
                                  cubit.clearFiles(files, index);
                                },
                              ),
                              10.width,
                              Expanded(
                                child: CustomButton(
                                  textStyle: TextStyles.font16WhiteBold,
                                  color: ColorsManager.green,
                                  title: 'الملف ${index + 1}',
                                  borderRadius: 16.r,
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.pdfViewer,
                                      arguments: {'path': files[index].path},
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    itemCount: files.length,
                  ),
        );
      },
    );
  }
}
