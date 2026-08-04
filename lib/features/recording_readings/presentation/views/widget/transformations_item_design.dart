import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/hypothesis/data/models/get_generators_reading_by_time.dart';

class TransformationsItemDesign extends StatelessWidget {
  const TransformationsItemDesign({super.key, required this.data});
  final GetGeneratorsReadingByTime data;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      children: [
        Expanded(
          child: Container(
            height: 120.h,
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: ColorsManager.softMainColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ColorsManager.mainColor),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'رقم المحول: ${data.generatorSerial ?? 'غير محدد'}',
                        style: TextStyles.font14DarkGrey,
                      ),
                      Container(
                        width: 1.w,
                        height: 60.h,
                        color: ColorsManager.mainColor,
                      ),
                      Text('التاريخ: ', style: TextStyles.font14DarkGrey),
                      Text(
                        data.readings![0].date != null
                            ? data.readings![0].date!.split('T')[0]
                            : 'غير محدد',
                        style: TextStyles.font14DarkGrey,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1.h,
                  color: ColorsManager.mainColor,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('B', style: TextStyles.font14DarkGrey),
                          Text(
                            data.readings![0].currentB.toString(),
                            style: TextStyles.font14DarkGrey,
                          ),
                        ],
                      ),
                      Container(
                        width: 1.w,
                        height: 60.h,
                        color: ColorsManager.mainColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Y', style: TextStyles.font14DarkGrey),
                          Text(
                            data.readings![0].currentY.toString(),
                            style: TextStyles.font14DarkGrey,
                          ),
                        ],
                      ),
                      Container(
                        width: 1.w,
                        height: 60.h,
                        color: ColorsManager.mainColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('R', style: TextStyles.font14DarkGrey),
                          Text(
                            data.readings![0].currentR.toString(),
                            style: TextStyles.font14DarkGrey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // data.imageUrl == null
        //     ? const SizedBox.shrink()
        //     : GestureDetector(
        //         onTap: () {
        //           context.pushNamed(
        //             Routes.displayNetworkAttachment,
        //             arguments: {
        //               'extention': data.imageUrl!.split('.').last,
        //               'attachmentPath': data.imageUrl!,
        //             },
        //           );
        //         },
        //         child: Image.asset(
        //           Assets.assetsImagesUploadFile,
        //           width: 25.w,
        //         ),
        //       )
      ],
    );
  }
}
