import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/widgets/custom_app_bar_slivers.dart';
import 'package:tanseiq/features/notifications/presentation/views/widgets/notification_item.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listImages = [
      Assets.assetsImagesDone,
      Assets.assetsImagesWarning,
      Assets.assetsImagesSupport2,
    ];
    List<String> titleImages = [
      'تم ارسال الاستبيان بنجاح',
      'طلبت شركة العاموريه الموافقه علي الاشارة بانتهاء مهام لمخيم بنسبة 100% ا وانتظار موافقتككم',
      'تحتاج شركة ضيوف الرحمان الي الدعم بوجود مشكلة في شاشة وجهة المستخدم لديها وتوقف حسابها',
    ];
    return Scaffold(
      key: key,
      body: CustomScrollView(
        slivers: [
          const CustomAppBarSlivers(
            displayNotificationIcon: false,
            tilte: 'الاشعارات',
            displayArrow: false,
          ),
          SliverList.builder(
            itemCount: listImages.length,
            itemBuilder:
                (context, index) => NotificationItem(
                  index: index,
                  image: listImages[index],
                  height:
                      index == 0
                          ? 115.h
                          : index == 1
                          ? 200.h
                          : 130.h,
                  title: titleImages[index],
                ),
          ),
        ],
      ),
    );
  }
}
