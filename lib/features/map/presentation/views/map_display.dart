import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';

class MapDisplay extends StatelessWidget {
  const MapDisplay({
    super.key,
    required this.lat,
    required this.lng,
    required this.information,
  });
  final double lat;
  final double lng;
  final String information;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBack(),
        title: Text('عرض الخريطة', style: TextStyles.font18BlackBold),
      ),
      body: GoogleMap(
        polygons: {
          Polygon(
            polygonId: const PolygonId('1'),
            points: [LatLng(lat, lng)],
            fillColor: ColorsManager.mainColor,
            strokeColor: ColorsManager.mainColor,
            strokeWidth: 2,
          ),
        },
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng),
          zoom: 13,
        ),
        markers: {
          Marker(
            infoWindow: InfoWindow(title: information),
            markerId: const MarkerId('destination'),
            position: LatLng(lat, lng),
          ),
        },
      ),
    );
  }
}
