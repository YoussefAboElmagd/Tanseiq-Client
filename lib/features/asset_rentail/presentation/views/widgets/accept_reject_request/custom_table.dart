import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: ColorsManager.softMainColor,
            border: Border.all(color: ColorsManager.mainColor),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              child: Center(
                child: Text('البند', style: TextStyles.font10SoftBlack),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              child: Center(
                child: Text('الوحدة', style: TextStyles.font10SoftBlack),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              child: Center(
                child: Text('العدد', style: TextStyles.font10SoftBlack),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              child: Center(
                child: Text('الباقة', style: TextStyles.font10SoftBlack),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              child: Center(
                child: Text('الاجمالي', style: TextStyles.font10SoftBlack),
              ),
            ),
          ],
        ),
        // First data row
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  'بند 1',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  'وحدة 1',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '2',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '100',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '120',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
          ],
        ),
        // Second data row
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  'بند 2',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  'وحدة 2',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '3',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '100',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '450',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
          ],
        ),
        // Third data row
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  'بند 3',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  'وحدة 3',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '1',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '120',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '120',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
          ],
        ),
        // Fourth data row
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  'بند 4',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  'وحدة 4',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '4',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '75',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: Text(
                  textAlign: TextAlign.center,
                  '300',
                  style: TextStyles.font12SoftBlack,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
