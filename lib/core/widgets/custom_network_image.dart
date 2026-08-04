import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/networking/api_constants.dart';
import 'package:tanseiq/core/theming/colors.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.image,
    this.errorImage,
    this.height,
    this.width,
  });
  final String image;
  final String? errorImage;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${ApiConstants.baseUrl}$image',
      height: height ?? 50.h,
      width: width ?? 50.w,
      fit: BoxFit.cover,
      httpHeaders: const {'Accept': 'image/*', 'Content-Type': 'image/*'},
      progressIndicatorBuilder: (context, url, downloadProgress) => circular,
      errorWidget:
          (context, url, error) =>
              errorImage != null
                  ? Image.asset(
                    errorImage!,
                    height: height ?? 50.h,
                    width: width ?? 50.w,
                    color: ColorsManager.black.withOpacity(0.2),
                  )
                  : Icon(Icons.error, color: ColorsManager.red, size: 35.r),
    );
  }
}
