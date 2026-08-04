import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/constant.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';

class AddNewSurveyFieldScreen1 extends StatefulWidget {
  const AddNewSurveyFieldScreen1({super.key, required this.id});
  final String id;

  @override
  State<AddNewSurveyFieldScreen1> createState() =>
      _AddNewSurveyFieldScreen1State();
}

String _selectedAttribute = 'نص'; // To store the selected attribute

final List<String> _attributes = [
  'نص',
  'تاريخ',
  'رقم الهاتف',
  'محتوي نصي',
  'رفع ملف',
];

class _AddNewSurveyFieldScreen1State extends State<AddNewSurveyFieldScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBack(),
        title: Text('اضافة حقل جديد', style: TextStyles.font18MainColorBold),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._attributes.map((attribute) {
                return RadioListTile<String>(
                  activeColor: ColorsManager.mainColor,
                  contentPadding: EdgeInsets.zero,
                  title: Constant.returnTrueWidget(attribute, false, context),
                  value: attribute,
                  groupValue: _selectedAttribute,
                  onChanged: (value) {
                    setState(() {
                      _selectedAttribute = value!;
                    });
                  },
                );
              }),
              10.height,
              const Divider(),
              20.height,
              CustomButton(
                title: 'اختيار',
                textStyle: TextStyles.font14WhiteBold,
                onTap: () {
                  context.pushNamed(
                    Routes.addNewSurveyFieldScreen2,
                    arguments: {
                      'id': widget.id,
                      'attributeName': _selectedAttribute,
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
