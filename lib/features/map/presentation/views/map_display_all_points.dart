import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/arrow_back.dart';
import 'package:tanseiq/core/widgets/empty_list.dart';
import 'package:tanseiq/core/widgets/loading_widget.dart';
import 'package:tanseiq/features/map/presentation/manager/map_cubit.dart';
import 'package:tanseiq/features/map/presentation/manager/map_states.dart';

class MapDisplayAllPoints extends StatefulWidget {
  const MapDisplayAllPoints({super.key});

  @override
  State<MapDisplayAllPoints> createState() => _MapDisplayAllPointsState();
}

class _MapDisplayAllPointsState extends State<MapDisplayAllPoints> {
  @override
  void initState() {
    super.initState();
    MapCubit.get(context).getAllCampsDimension();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapStates>(
      builder: (context, state) {
        var cubit = MapCubit.get(context);
        if (state is GetAllCampLoading) return const LoadingWidget();
        return Scaffold(
          appBar: AppBar(
            leading: const ArrowBack(),
            title: Text('عرض الخريطة', style: TextStyles.font18BlackBold),
          ),
          body:
              cubit.campsDimension.isEmpty
                  ? const EmptyList()
                  : GoogleMap(
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        cubit.campsDimension[0].lat,
                        cubit.campsDimension[0].lng,
                      ),
                      zoom: 13,
                    ),
                    markers:
                        cubit.campsDimension
                            .map(
                              (camp) => Marker(
                                markerId: MarkerId(camp.campNumber),
                                position: LatLng(camp.lat, camp.lng),
                                infoWindow: InfoWindow(
                                  title: camp.campNumber,
                                  snippet: camp.campNumber,
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.map,
                                      arguments: {
                                        'lat': camp.lat,
                                        'lng': camp.lng,
                                        'information': camp.campNumber,
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                            .toSet(),
                    // polygons: {
                    //   Polygon(
                    //     consumeTapEvents: true,
                    //     geodesic: true,
                    //     visible: true,
                    //     onTap: () {
                    //       print('object');
                    //       showDialog(
                    //         context: context,
                    //         builder: (context) => const AlertDialog(
                    //           title: Text('data'),
                    //         ),
                    //       );
                    //     },
                    //     polygonId: const PolygonId('1'),
                    //     points: cubit.campsDimension
                    //         .map((e) => LatLng(e.lat, e.lng))
                    //         .toList(),
                    //     fillColor: ColorsManager.red,
                    //     strokeColor: ColorsManager.mainColor,
                    //     strokeWidth: 2,
                    //   ),
                    // },
                  ),
        );
      },
    );
  }
}
