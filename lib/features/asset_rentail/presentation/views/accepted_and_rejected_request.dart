import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_cubit.dart';
import 'package:tanseiq/features/asset_rentail/presentation/manager/asset_rentail_states.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/attributes_pdf_button.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/camp_number_item_design.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/reject_item_details.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/accept_reject_request/reschedule_item.dart';
import 'package:tanseiq/features/asset_rentail/presentation/views/widgets/details/rentail_details_title_row.dart';

class AcceptedAndRejectedRequest extends StatelessWidget {
  const AcceptedAndRejectedRequest({super.key, required this.isRejected});
  final bool isRejected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetRentailCubit, AssetRentailStates>(
      builder: (context, state) {
        var cubit = AssetRentailCubit.get(context);
        return Scaffold(
          appBar: customAppBar(context: context, title: 'تأجير الاصول'),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20.h,
                  children: [
                    RentailDetailsTitleRow(
                      title: !isRejected ? 'متابعة الرفض' : 'متابعة القبول',
                      image: Assets.assetsImagesContracts,
                    ),
                    const AttributesPdfButton(),
                    // ?const CampNumberItemDesign(),
                    const CampNumberItemDesign(),
                    if (!isRejected)
                      Text('ادارة المهام', style: TextStyles.font16BlackBold)
                    else
                      RejectItemDetails(cubit: cubit),
                    if (!isRejected)
                      const RescheduleItem()
                    else
                      const SizedBox.shrink(),
                    if (!isRejected)
                      CustomButton(
                        color: ColorsManager.darkRed,
                        textStyle: TextStyles.font16WhiteBold,
                        title: 'اغلاق الطلب',
                        onTap: () {},
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // () record
  // {}
}
