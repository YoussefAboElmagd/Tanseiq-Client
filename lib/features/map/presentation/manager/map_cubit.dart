// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
// import 'package:tanseiq/core/helpers/location_service.dart';

// class MapCubit extends Cubit<MapStates> {
//   MapCubit(this.ordersRepos) : super(MapInitial());
//   final MapRepos ordersRepos;
//   static MapCubit get(context) => BlocProvider.of(context);

//   final LocationService _locationService = LocationService();
//   final Completer<GoogleMapController> mapController =
//       Completer<GoogleMapController>();

//   List<LatLng> polylineCoordinates = [];
//   Map<PolylineId, Polyline> polylines = {};
//   LocationData? currentLocation;

//   StreamSubscription<LocationData>? _locationSubscription; // Add this line
//   String? distance;
//   String? duration;
//   BitmapDescriptor? sourceIcon;
//   Future<void> initializeMap({
//     required double latitude,
//     required double longitude,
//   }) async {
//     if (isClosed) return; // Ensure Cubit is not closed
//     emit(OrderLoading());
//     sourceIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(),
//       Assets.assetsImagesDot,
//     );

//     await _getCurrentLocation();
//     await _getPolyLines(
//       latitude: latitude,
//       longitude: longitude,
//     );

//     if (isClosed) return; // Ensure Cubit is not closed

//     // Fetch distance and duration
//     if (currentLocation != null) {
//       await fetchDistanceAndDuration(
//         LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
//         LatLng(latitude, longitude),
//       );
//     }

//     emit(OrderLoaded());
//   }

//   Future<void> fetchDistanceAndDuration(
//     LatLng origin,
//     LatLng destination,
//   ) async {
//     const apiKey = 'AIzaSyB12ZQiLlyulgtcPvcs_A7gnkd0JWU5YSc';
//     final url = Uri.parse(
//       '${ApiConstants.distanceBaseUrl}${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey',
//     );

//     try {
//       final response = await http.get(url);

//       // Check if the Cubit is closed before emitting any state
//       if (isClosed) return;

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['status'] == 'OK') {
//           final routes = data['routes'][0];
//           final legs = routes['legs'][0];

//           // Check again if the Cubit is closed before emitting
//           if (isClosed) return;

//           // Store distance and duration
//           distance = legs['distance']['text'];
//           duration = legs['duration']['text'];

//           emit(OrderDistanceDurationUpdated(
//             distance: distance!,
//             duration: duration!,
//           ));
//         } else {
//           if (isClosed) return;
//           emit(OrderError('No route found.'));
//         }
//       } else {
//         if (isClosed) return;
//         emit(OrderError('Failed to load directions: ${response.statusCode}'));
//       }
//     } catch (e) {
//       if (isClosed) return;
//       emit(OrderError('Error: $e'));
//     }
//   }

//   Future<void> _getCurrentLocation() async {
//     if (isClosed) return; // Ensure Cubit is not closed

//     bool hasService = await _locationService.checkAndRequestLocationService();
//     if (!hasService) {
//       if (isClosed) return; // Ensure Cubit is not closed
//       emit(OrderError('Location service is disabled.'));
//       return;
//     }

//     bool hasPermission =
//         await _locationService.checkAndRequestLocationPermission();
//     if (!hasPermission) {
//       if (isClosed) return; // Ensure Cubit is not closed
//       emit(OrderError('Location permission denied.'));
//       return;
//     }

//     currentLocation = await _locationService.getCurrentLocation();

//     // Cancel any existing subscription
//     await _locationSubscription?.cancel();

//     // Listen to location updates
//     _locationSubscription =
//         _locationService.getLocationUpdates().listen((location) {
//       if (isClosed) return; // Ensure Cubit is not closed
//       currentLocation = location;
//       if (isClosed) return;
//       _animateCameraToLocation(location);
//       emit(OrderLocationUpdated(location));
//     });
//   }

//   Future<void> _getPolyLines({
//     required double latitude,
//     required double longitude,
//   }) async {
//     if (isClosed || currentLocation == null) return;

//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleApiKey: 'AIzaSyB12ZQiLlyulgtcPvcs_A7gnkd0JWU5YSc',
//       request: PolylineRequest(
//         origin: PointLatLng(
//           currentLocation!.latitude!,
//           currentLocation!.longitude!,
//         ),
//         destination: PointLatLng(latitude, longitude),
//         mode: TravelMode.driving,
//       ),
//     );

//     if (result.points.isNotEmpty) {
//       polylineCoordinates = result.points
//           .map((point) => LatLng(point.latitude, point.longitude))
//           .toList();
//       _addPolyLine();
//     }
//   }

//   void _addPolyLine() {
//     if (isClosed) return; // Ensure Cubit is not closed

//     PolylineId id = const PolylineId('route');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: const Color.fromARGB(255, 117, 152, 240),
//       points: polylineCoordinates,
//       width: 6,
//     );
//     polylines[id] = polyline;
//     emit(OrderPolylineUpdated(polylines));
//   }

//   void _animateCameraToLocation(LocationData location) {
//     if (isClosed) return; // Ensure Cubit is not closed

//     mapController.future.then((controller) {
//       controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: LatLng(location.latitude!, location.longitude!),
//             zoom: 15,
//           ),
//         ),
//       );
//     });
//   }

//   late GetAllOrders getAllOrders;
//   Future emitGetAllOrders() async {
//     emit(GetAllOrdersLoading());
//     final response = await ordersRepos.getMyOrders();
//     response.when(
//       success: (success) {
//         getAllOrders = success;
//         emit(GetAllOrdersSuccess());
//       },
//       failure: (error) {
//         emit(GetAllOrdersFailure(error.failure.message ?? ''));
//       },
//     );
//   }

//   late GetCurrentOrder currentOrder;
//   Future emitGetCurrentOrder() async {
//     emit(GetCurrentOrderLoading());
//     final response = await ordersRepos.getCurrentOrder();
//     await response.when(
//       success: (success) async {
//         currentOrder = success;
//         emit(GetCurrentOrderSuccess());
//         await initializeMap(
//           latitude: double.parse(currentOrder.data.destinationLat),
//           longitude: double.parse(currentOrder.data.destinationLng),
//         );
//       },
//       failure: (error) {
//         emit(GetCurrentOrderFailure(error.failure.message ?? ''));
//       },
//     );
//   }

//   Future emitAcceptOrders({
//     required String orderId,
//   }) async {
//     emit(AcceptOrdersLoading());
//     final response = await ordersRepos.acceptOrder(id: orderId);
//     await response.when(
//       success: (success) async {
//         emit(AcceptOrdersSuccess());
//         await emitGetAllOrders();
//       },
//       failure: (error) {
//         emit(AcceptOrdersFailure(error.failure.message ?? ''));
//       },
//     );
//   }

//   Future emitCompleteOrdersFromHome({
//     required String orderId,
//     required BuildContext context,
//   }) async {
//     emit(CompeleteOrdersLoading());
//     final response = await ordersRepos.completeOrder(id: orderId);
//     await response.when(
//       success: (success) async {
//         await emitGetAllOrders();
//       },
//       failure: (error) {
//         emit(CompeleteOrdersFailure(error.failure.message ?? ''));
//       },
//     );
//   }

//   Future emitCompleteOrders({
//     required String orderId,
//     required BuildContext context,
//   }) async {
//     emit(CompeleteOrdersLoading());
//     final response = await ordersRepos.completeOrder(id: orderId);
//     await response.when(
//       success: (success) async {
//         emit(CompeleteOrdersSuccess());
//         await close();
//       },
//       failure: (error) {
//         emit(CompeleteOrdersFailure(error.failure.message ?? ''));
//       },
//     );
//   }

//   Future emitCompleteOrdersTracking({
//     required String orderId,
//     required BuildContext context,
//   }) async {
//     emit(CompeleteOrdersLoading());
//     final response = await ordersRepos.completeOrder(id: orderId);
//     await response.when(
//       success: (success) async {
//         await emitGetCurrentOrder();
//         await close();
//       },
//       failure: (error) {
//         emit(CompeleteOrdersFailure(error.failure.message ?? ''));
//       },
//     );
//   }

//   @override
//   Future<void> close() {
//     _locationSubscription?.cancel(); // Cancel the location subscription
//     return super.close();
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanseiq/features/camp/data/models/get_all_camps_dimension_response.dart';
import 'package:tanseiq/features/map/data/repos/map_repo.dart';
import 'package:tanseiq/features/map/presentation/manager/map_states.dart';

class MapCubit extends Cubit<MapStates> {
  MapCubit(this.mapRepo) : super(MapInitial());
  final MapRepo mapRepo;
  static MapCubit get(context) => BlocProvider.of(context);

  List<GetAllCampsDimensionResponse> campsDimension = [];
  Future<void> getAllCampsDimension() async {
    campsDimension.clear();
    emit(GetAllCampLoading());
    final result = await mapRepo.getAllCampsDimension();
    result.when(
      success: (data) {
        campsDimension.addAll(data);
        emit(GetAllCampSuccess());
      },
      failure: (error) {
        emit(GetAllCampError(error.failure.message ?? ''));
      },
    );
  }
}
