import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';

class CampPositinoMap extends StatelessWidget {
  const CampPositinoMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.soft3Grey,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GoogleMap(
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: false, // Disable if not needed
        rotateGesturesEnabled: false, // Disable if not needed
        liteModeEnabled: false, //
        zoomControlsEnabled: false,
        initialCameraPosition: const CameraPosition(
          target: LatLng(31.238495720942403, 29.967417179449182),
          zoom: 13,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('campMarker'),
            position: LatLng(31.238495720942403, 29.967417179449182),
          ),
        },
      ),
    );
  }
}

class OptimizedCampPositionMap extends StatefulWidget {
  const OptimizedCampPositionMap({super.key});

  @override
  State<OptimizedCampPositionMap> createState() =>
      _OptimizedCampPositionMapState();
}

class _OptimizedCampPositionMapState extends State<OptimizedCampPositionMap> {
  bool _showRealMap = false;

  @override
  void initState() {
    super.initState();
    // Delay map loading
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() => _showRealMap = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showRealMap ? const CampPositinoMap() : Center(child: circular);
  }
}
