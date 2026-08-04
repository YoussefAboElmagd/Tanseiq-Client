import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/features/recording_readings/presentation/manager/recording_readings_cubit.dart';
import 'package:tanseiq/features/recording_readings/presentation/manager/recording_readings_states.dart';
import 'package:tanseiq/features/recording_readings/presentation/views/widget/markers_details_alert.dart';

class ReadingsMapDisplay extends StatelessWidget {
  const ReadingsMapDisplay({
    super.key,
    required this.cubit,
    required this.state,
  });
  final RecordingReadingsCubit cubit;
  final RecordingReadingsStates state;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: ColorsManager.green,
      showTrailingIcon: true,
      onExpansionChanged: (value) {
        if (value) {
          cubit.emitGetMapPoints();
        }
      },
      trailing: const Icon(
        Icons.keyboard_arrow_down,
        color: ColorsManager.green,
      ),
      leading: const Icon(Icons.location_on, color: ColorsManager.red),
      title: Text('خريطة الموقع', style: TextStyles.font16GreenBold),
      expandedAlignment: Alignment.centerLeft,
      minTileHeight: 20.h,
      children: [
        state is GetMapPointsLoadingState
            ? circular
            : cubit.mapPoints.isEmpty
            ? EmptyList(
              text: 'لا يوجد نقاط في الخريطة',
              textStyle: TextStyles.font16GreenBold,
              imageColor: ColorsManager.green,
              image: Assets.assetsImagesTint,
            )
            : Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              height: 350.h,
              child: GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(cubit.mapPoints[0].latitude!),
                    double.parse(cubit.mapPoints[0].longitude!),
                  ),
                  zoom: 13,
                ),
                markers:
                    cubit.mapPoints
                        .map(
                          (point) => Marker(
                            markerId: MarkerId(point.id.toString()),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) =>
                                        MarkerDetailsAlert(point: point),
                              );
                            },
                            position: LatLng(
                              double.parse(point.latitude!),
                              double.parse(point.longitude!),
                            ),
                          ),
                        )
                        .toSet(),
              ),
            ),
      ],
    );
  }
}
