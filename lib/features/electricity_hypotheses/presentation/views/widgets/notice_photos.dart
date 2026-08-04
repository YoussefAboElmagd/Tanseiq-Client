import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_cubit.dart';
import 'package:tanseiq/features/electricity_hypotheses/presentation/manager/electricity_hypotheses_states.dart';

class NoticePhotos extends StatelessWidget {
  const NoticePhotos({super.key, required this.noticeIndex});
  final int noticeIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectricityHypothesesCubit, ElectricityHypothesesStates>(
      builder: (context, state) {
        var cubit = context.read<ElectricityHypothesesCubit>();
        final caseImage =
            cubit.image1.length > noticeIndex
                ? cubit.image1[noticeIndex]
                : null;
        final placeImage =
            cubit.image2.length > noticeIndex
                ? cubit.image2[noticeIndex]
                : null;

        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  cubit
                      .emitPickImage(
                        context: context,
                        imageNumber: 1,
                        index: noticeIndex,
                      )
                      .then((val) {
                        if (cubit.image1.length > noticeIndex &&
                            cubit.image1[noticeIndex] != null) {
                          cubit.addOrUpdateNoteAtIndex(
                            caseImage: cubit.image1[noticeIndex]!,
                            index: noticeIndex,
                          );
                        }
                      });
                },
                child: Container(
                  height: 100.h,
                  decoration: DottedDecoration(
                    shape: Shape.box,
                    color: ColorsManager.mainColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: ColorsManager.soft3Grey,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 1.w,
                      vertical: 1.h,
                    ),
                    child:
                        caseImage == null
                            ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 15.h,
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 30.w,
                                    color: ColorsManager.grey,
                                  ),
                                  5.height,
                                  Text(
                                    'صورة الحالة',
                                    style: TextStyles.font14NormalGrey,
                                  ),
                                ],
                              ),
                            )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.file(caseImage, fit: BoxFit.cover),
                            ),
                  ),
                ),
              ),
            ),
            16.width,
            Expanded(
              child: InkWell(
                onTap: () {
                  cubit
                      .emitPickImage(
                        context: context,
                        imageNumber: 2,
                        index: noticeIndex,
                      )
                      .then((val) {
                        if (cubit.image2.length > noticeIndex &&
                            cubit.image2[noticeIndex] != null) {
                          cubit.addOrUpdateNoteAtIndex(
                            placeImage: cubit.image2[noticeIndex]!,
                            index: noticeIndex,
                          );
                        }
                      });
                },
                child: Container(
                  height: 100.h,
                  decoration: DottedDecoration(
                    shape: Shape.box,
                    color: ColorsManager.mainColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: ColorsManager.soft3Grey,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 1.w,
                      vertical: 1.h,
                    ),
                    child:
                        placeImage == null
                            ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 15.h,
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 30.w,
                                    color: ColorsManager.grey,
                                  ),
                                  5.height,
                                  Text(
                                    'صورة معلم المكان',
                                    style: TextStyles.font14NormalGrey,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.file(placeImage, fit: BoxFit.cover),
                            ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
