import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_app_bar.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_cubit.dart';
import 'package:tanseiq/features/complains/presentation/manager/complains_states.dart';

class DisplayPickedMap extends StatelessWidget {
  const DisplayPickedMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'موقع البلاغ'),
      body: BlocBuilder<ComplainsCubit, ComplainsStates>(
        builder: (context, state) {
          var cubit = ComplainsCubit.get(context);
          return Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 10.h),
            child: Column(
              spacing: 10.h,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 40.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsManager.soft2Grey,
                      ),
                      child: Image.asset(
                        Assets.assetsImagesLocation,
                        width: 20.r,
                      ),
                    ),
                    10.width,
                    Text('حدد موقع', style: TextStyles.font14Black),
                  ],
                ),
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: GoogleMap(
                      mapType: MapType.satellite,
                      onMapCreated: (controller) {
                        cubit.googleController = controller;
                      },
                      onTap: (latlng) {
                        cubit.emitSelectLocation(location: latlng);
                      },
                      zoomControlsEnabled: false,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(45.12765171815886, 23.87020379304886),
                        zoom: 17,
                      ),
                      markers: cubit.markers,
                    ),
                  ),
                ),
                CustomButton(
                  textStyle: TextStyles.font16WhiteBold,
                  color: ColorsManager.green,
                  title: 'استمرار',
                  onTap: () {
                    context.pushNamed(
                      Routes.addComplains,
                      arguments: {'markers': cubit.markers},
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
