import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_states.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/add_complain/add_complain_attributes.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/add_complain/add_complain_title_row.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/add_complain/pick_image_row.dart';
import 'package:tanseiq/features/complains/presentation/views/widgets/complain_bloc_listener.dart';

class AddComplain extends StatefulWidget {
  const AddComplain({
    super.key,
    // required this.markers
    // , required this.isCadana
  });
  // final Set<Marker> markers;
  // final bool isCadana;

  @override
  State<AddComplain> createState() => _AddComplainState();
}

class _AddComplainState extends State<AddComplain> {
  @override
  void initState() {
    super.initState();
    ComplainsCubit.get(context).emitAddComplainGetMethods();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplainsCubit, ComplainsStates>(
      builder: (context, state) {
        var cubit = ComplainsCubit.get(context);
        if (state is GetAllCampNumberLoadingState ||
            state is GetZonesLoadingState ||
            state is GetComplainTypeLoadingState) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: customAppBar(context: context, title: 'اضافة بلاغ'),
          body:
              state is GetAllCampNumberErrorState ||
                      state is GetZonesErrorState ||
                      state is GetComplainTypeErrorState
                  ? EmptyList(
                    text: 'خطأ في تحميل البيانات',
                    onRefresh: () => cubit.emitAddComplainGetMethods(),
                  )
                  : state is GetComplainTypeErrorState
                  ? EmptyList(
                    text: 'لا يوجد نوع بلاغ',
                    onRefresh: () => cubit.emitAddComplainGetMethods(),
                  )
                  : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SingleChildScrollView(
                        child: Form(
                          key: cubit.formKey,
                          child: Column(
                            spacing: 20.h,
                            children: [
                              const AddComplainTitleRow(),
                              AddComplainAttributes(
                                // markers: widget.markers,
                                cubit: cubit,
                              ),
                              PickImageRow(cubit: cubit),
                              CustomButton(
                                color: ColorsManager.mainColor,
                                borderRadius: 16.r,
                                textStyle: TextStyles.font16WhiteBold,
                                title: 'ارسال',
                                onTap: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    // widget.isCadana
                                    //     ? cubit.emitAddProblemCadana()
                                    //     : cubit.emitAddProblem();
                                    cubit.emitAddProblem();
                                  }
                                },
                              ),
                              const ComplainBlocListener(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
        );
      },
    );
  }
}
