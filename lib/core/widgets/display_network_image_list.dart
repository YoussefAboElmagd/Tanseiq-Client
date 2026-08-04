import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/custom_network_image.dart';
import 'package:tanseiq/features/complains/data/models/get_all_complains_response.dart';

class DisplayNetworkImageList extends StatelessWidget {
  const DisplayNetworkImageList({super.key, required this.pathes});
  final List<ProblemMediaData> pathes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: ''),
      body: SafeArea(
        child: ListView.builder(
          itemCount: pathes.length,
          itemBuilder:
              (context, index) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CustomNetworkImage(
                        width: double.infinity,
                        height: 350.h,
                        image: pathes[index].path!,
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
