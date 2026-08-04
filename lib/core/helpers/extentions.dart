// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:lottie/lottie.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/camp/data/models/get_status_dropdown_response.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(
    String routeName, {
    Object? arguments,
    bool? routerNavigator,
  }) {
    return Navigator.of(
      this,
      rootNavigator: routerNavigator ?? false,
    ).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntill(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
      rootNavigator: true,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
  void popAlert() => Navigator.of(this, rootNavigator: true).pop();
}

// Sized box
extension IntExtension on int? {
  int validate({int value = 0}) {
    return this ?? value;
  }

  Widget get height => SizedBox(height: this?.toDouble().h);
  Widget get width => SizedBox(width: this?.toDouble().w);
}

ToastFuture toast({
  required BuildContext context,
  Color backgroundColor = ColorsManager.darkRed,
  String message = 'Please Fill All Fields',
}) => showToast(
  message,
  context: context,
  animation: StyledToastAnimation.slideFromBottom,
  reverseAnimation: StyledToastAnimation.sizeFade,
  position: StyledToastPosition.center,
  animDuration: const Duration(milliseconds: 900),
  duration: const Duration(milliseconds: 1800),
  backgroundColor: backgroundColor,
  borderRadius: BorderRadius.circular(15.r),
  textStyle: TextStyle(fontSize: 18.sp, color: Colors.white),
  curve: Curves.fastLinearToSlowEaseIn,
  reverseCurve: Curves.fastLinearToSlowEaseIn,
);

Widget circular = Center(
  child: SizedBox(
    width: 250.w,
    height: 250.h,
    child: Lottie.asset('assets/images/loading.json'),
  ),
);

BoxDecoration loginDecorationContainerFields = const BoxDecoration(
  image: DecorationImage(
    alignment: Alignment.bottomCenter,
    image: AssetImage(Assets.assetsImagesBackground),
  ),
);

List<String> images = [
  Assets.assetsImagesTint,
  Assets.assetsImagesTasks,
  Assets.assetsImagesDoneTasks,
  Assets.assetsImagesWarningTasks,
];

List<String> homeStatisticsImages = [
  Assets.assetsImagesDoneTasks,
  Assets.assetsImagesWarningTasks,
  Assets.assetsImagesTint,
  Assets.assetsImagesTasks,
];
List<String> homeStatisticsTitles = [
  'مخيمات منتهية',
  'مخيمات متأخرة',
  'مخيمات قيد التنفيذ',
  'اجمالي المخيمات',
];
List<Color> colors = [
  ColorsManager.softMainColor,
  ColorsManager.softBlue,
  ColorsManager.softGreen,
  ColorsManager.softRed,
];
List<Color> homeStatisticsColors = [
  ColorsManager.softGreen,
  ColorsManager.softRed,
  ColorsManager.softMainColor,
  ColorsManager.softBlue,
];
List<TextStyle> styles = [
  TextStyles.font18MainColorBold,
  TextStyles.font18BlueBold,
  TextStyles.font18GreenBold,
  TextStyles.font18DarkRedBold,
];
List<TextStyle> homeStatisticsStyles = [
  TextStyles.font18GreenBold,
  TextStyles.font18DarkRedBold,
  TextStyles.font18MainColorBold,
  TextStyles.font18BlueBold,
];
List<Color> tintStatusColor = [
  ColorsManager.green,
  ColorsManager.orange,
  ColorsManager.darkRed,
];
List<String> tintStatusTitles = ['جاهز', 'قيد التجهيز', 'متأخر'];
List<int> tintStatusPercentage = [50, 20, 30];

List<Color> responseAvgColor = [
  ColorsManager.green,
  ColorsManager.darkBlue,
  ColorsManager.pink,
];
List<TextStyle> responseAvgStyle = [
  TextStyles.font18GreenBold,
  TextStyles.font18BlueBold,
  TextStyles.font18PinkBold,
];
List<String> drawerTitles = [
  'المخيمات',
  'شركات تقديم الخدمة',
  'فرق العمل',
  'تقارير',
  'البيانات الرئيسية',
  'محادثات',
  'الشكاوي',
  'التواصل والدعم',
];

List<String> drawerIcons = [
  Assets.assetsImagesTint,
  Assets.assetsImagesCompany,
  Assets.assetsImagesTeam,
  Assets.assetsImagesReports2,
  Assets.assetsImagesMainData,
  Assets.assetsImagesChat,
  Assets.assetsImagesContactUs,
  Assets.assetsImagesConnect,
];

List<String> imagesBottomNavBar = [
  Assets.assetsImagesHome,
  Assets.assetsImagesSupport2,
  Assets.assetsImagesSetting,
  Assets.assetsImagesUser,
];
List<String> names = ['الصفحة الرئيسية', 'الدعم', 'الاعدادات', 'الملف الشخصي'];

List<String> campTintPrepareListDetails = [
  'طرابيل الجوانب',
  'دورات مياه',
  'عدد المطابخ',
  'تكيف',
  'افياش',
  'مطابخ',
  'ممرات',
];

List<TextStyle> loadStyles = [
  TextStyles.font16GreenBold,
  TextStyles.font16RedBold,
  TextStyles.font16MainColorBold,
  TextStyles.font16YellowBold,
];

List<String> loadTitles = [
  'قياس طبيعي: ',
  'قياس خطر: ',
  'عدد المحولات: ',
  'قياس عالي: ',
];

List<String> rentailTitles = [
  'الدول العربية',
  'افرقيا غير العربية',
  'مطوره شرق اسيا',
  'مطوره جنوب اسيا',
  'القابلة للتاجير',
];

List<String> rentailDetailsTitles = [
  'المشعر',
  'رقم المربع',
  'البوابة',
  'الشارع',
  'مساحة الخيام',
  'عدد الحجاج',
  'نسبة التسكين',
  'الجنسية',
  'الفئة',
  'رقم مركز الخدمة',
  'اسم رئيس المركز',
  'رقم رئيس المركز',
  'الشركة الفرعية',
  'عدد المطابخ',
  'عدد مجمعات دورات المياه',
  'عدد دورات المياه',
  'عدد حجاج لكل دورة مياه',
  'مقاول',
  'المرحلة الادارية',
];

List<String> titles = ['مخيمات', 'جاري العمل', 'جاهز', 'متأخر'];

List<String> performanceindicatorsTitles = [
  'مخيمات قيد التنفيذ',
  'اجمالي المخيمات',
  'مخيمات منتهية',
  'مخيمات متأخرة',
];

List<Color> statusColor = [
  ColorsManager.green,
  ColorsManager.yellow,
  ColorsManager.darkBlue,
  ColorsManager.red,
];

List<GetStatusDropdownResponse> statusDropdown = [
  GetStatusDropdownResponse(id: 3, name: 'القبول'),
  GetStatusDropdownResponse(id: 1, name: 'تحت الانتظار'),
  GetStatusDropdownResponse(id: 4, name: 'جاري الدراسة'),
  GetStatusDropdownResponse(id: 2, name: 'الرفض'),
];

List<Color> colorsAnalysis = [
  ColorsManager.orange,
  ColorsManager.green,
  ColorsManager.mainColor,
  ColorsManager.darkRed,
  ColorsManager.darkBlue,
  ColorsManager.yellow,
  ColorsManager.burbel,
];

Map<String, Color> StatusColor = {
  'خيام': ColorsManager.cyan,
  'كهرباء': ColorsManager.yellow2,
  'ارصفة': ColorsManager.green,
  'تكييف': ColorsManager.darkRed,
  'مطبخ': ColorsManager.darkBlue,
  'اسوار': ColorsManager.burbel,
};

Map<String, Color> TitlesColor = {
  'تم الاصلاح': ColorsManager.green,
  'تم الابلاغ': ColorsManager.orange,
  'عدم اختصاص': ColorsManager.mainColor,
  'لم يتم الاصلاح': ColorsManager.darkRed,
};
