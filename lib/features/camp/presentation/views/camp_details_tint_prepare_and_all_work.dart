import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/custom_form_field.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_cubit.dart';
import 'package:tanseiq/features/camp/presentation/manager/camp_states.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_prepare_and_all_work/construction_tint_item.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_prepare_and_all_work/prepare_analysis_item.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_prepare_and_all_work/prepare_details_attributes.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_prepare_and_all_work/prepare_or_all_work_change_item.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_prepare_and_all_work/tint_name_row.dart';

class CampDetailsTintPrepareAndAllWork extends StatefulWidget {
  const CampDetailsTintPrepareAndAllWork({
    super.key,
    required this.currentIndex,
  });
  final int currentIndex;

  @override
  State<CampDetailsTintPrepareAndAllWork> createState() =>
      _CampDetailsTintPrepareAndAllWorkState();
}

class _CampDetailsTintPrepareAndAllWorkState
    extends State<CampDetailsTintPrepareAndAllWork> {
  @override
  void initState() {
    super.initState();
    if (widget.currentIndex == 0) {
      CampCubit.get(context).emitGetPreparing();
    } else {
      CampCubit.get(context).emitGetBuilding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampCubit, CampStates>(
      builder: (context, state) {
        var cubit = CampCubit.get(context);
        if (state is GetPreparingCampServicesLoading ||
            state is GetStatusDropdownLoading ||
            state is GetCampBuildingWorkLoading &&
                (cubit.buildingWorksResponse == null)) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: customAppBar(context: context, title: 'اعمال تشيد الخيام'),
          body:
              state is GetPreparingCampServicesError ||
                      state is GetStatusDropdownError ||
                      state is GetCampBuildingWorkError ||
                      state is GetCampBuildingWorkError
                  ? const EmptyList(text: 'خطأ في الانترنت او الاتصال بالسيرفر')
                  : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TintNameRow(),
                          10.height,
                          const PrepareAnalysisItem(),
                          10.height,
                          const PrepareDetailsAtrributes(),
                          10.height,
                          PrepareOrAllWorkChangeItem(
                            currentIndex: widget.currentIndex,
                          ),
                          10.height,
                          SizedBox(
                            height: 350.h,
                            child: ListView.builder(
                              controller: ScrollController(),
                              itemBuilder:
                                  (context, index) =>
                                      widget.currentIndex == 1
                                          ? ConstructionTintItem(
                                            supply: (value) {
                                              cubit.changeSupply(
                                                cubit
                                                    .buildingWorksResponse!
                                                    .data,
                                                index,
                                              );
                                            },
                                            structure: (value) {
                                              cubit.changeStructure(
                                                cubit
                                                    .buildingWorksResponse!
                                                    .data,
                                                index,
                                              );
                                            },
                                            index: index,
                                            data: cubit.buildingWorksResponse,
                                          )
                                          : const SizedBox(),
                              // : PrepareTintItem(
                              //     save: () {},
                              //     parentIndex: index,
                              //     data: cubit.prepare,
                              //   ),
                              itemCount:
                                  widget.currentIndex == 1
                                      ? cubit.buildingWorksResponse!.data.length
                                      : cubit.prepare.length,
                            ),
                          ),
                          10.height,
                          Text('الملاحظات', style: TextStyles.font14Green),
                          5.height,
                          CustomFormField(
                            isHint: true,
                            maxLines: 4,
                            hint: 'نص',
                            validator: (value) {},
                          ),
                          10.height,
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    cubit.emitPickFiles(context: context);
                                  },
                                  child: Image.asset(
                                    Assets.assetsImagesAddFile,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    cubit.emitPickImage(context: context);
                                  },
                                  child: Image.asset(
                                    Assets.assetsImagesAddImage2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          cubit.files.isEmpty ? 0.height : 10.height,
                          cubit.files.isEmpty
                              ? const SizedBox.shrink()
                              : CustomButton(
                                color: ColorsManager.green,
                                textStyle: TextStyles.font16WhiteBold,
                                title: 'عرض الملفات',
                                borderRadius: 16.r,
                                onTap: () {
                                  context.pushNamed(
                                    Routes.displayFiles,
                                    arguments: {'files': cubit.files},
                                  );
                                },
                              ),
                          // cubit.images.isEmpty ? 0.height : 10.height,
                          // cubit.images.isEmpty
                          //     ? const SizedBox.shrink()
                          //     : CustomButton(
                          //         color: ColorsManager.green,
                          //         textStyle: TextStyles.font16WhiteBold,
                          //         title: 'عرض الصور',
                          //         borderRadius: 16.r,
                          //         onTap: () {
                          //           context.pushNamed(
                          //             Routes.displayImages,
                          //             arguments: {
                          //               'images': cubit.images,
                          //             },
                          //           );
                          //         },
                          //       ),
                          10.height,
                          Image.asset(Assets.assetsImagesPrepareTint),
                          10.height,
                          CustomButton(
                            color: ColorsManager.mainColor,
                            textStyle: TextStyles.font16WhiteBold,
                            title: 'عمل تقرير',
                            borderRadius: 16.r,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
        );
      },
    );
  }
}
