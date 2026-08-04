import 'package:flutter/material.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/styles.dart';

class ReviewAndDeleteAttachmentRow extends StatelessWidget {
  const ReviewAndDeleteAttachmentRow({
    super.key,
    required this.extention,
    required this.path,
    this.deleteButton,
  });

  final String extention;
  final String path;
  final Function()? deleteButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            context.pushNamed(
              Routes.displayAttachment,
              arguments: {
                'extention': extention.toLowerCase(),
                'attachmentPath': path,
              },
            );
          },
          child: Text('عرض', style: TextStyles.font16MainColorBold),
        ),
        TextButton(
          onPressed: deleteButton,
          child: Text('حذف', style: TextStyles.font16DarkRedBold),
        ),
      ],
    );
  }
}
