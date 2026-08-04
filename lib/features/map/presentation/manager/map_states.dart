import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

abstract class MapStates {}

class MapInitial extends MapStates {}

class OrderInitial extends MapStates {}

class SourceIconLoaded extends MapStates {}

class OrderLoading extends MapStates {}

class OrderLoaded extends MapStates {}

class OrderError extends MapStates {
  final String message;
  OrderError(this.message);
}

class OrderLocationUpdated extends MapStates {
  final LocationData location;
  OrderLocationUpdated(this.location);
}

class OrderPolylineUpdated extends MapStates {
  final Map<PolylineId, Polyline> polylines;
  OrderPolylineUpdated(this.polylines);
}

class OrderDistanceDurationUpdated extends MapStates {
  final String distance;
  final String duration;

  OrderDistanceDurationUpdated({
    required this.distance,
    required this.duration,
  });
}

class GetAllOrdersLoading extends MapStates {}

class GetAllOrdersSuccess extends MapStates {}

class GetAllOrdersFailure extends MapStates {
  final String message;
  GetAllOrdersFailure(this.message);
}

class GetCurrentOrderLoading extends MapStates {}

class GetCurrentOrderSuccess extends MapStates {}

class GetCurrentOrderFailure extends MapStates {
  final String message;
  GetCurrentOrderFailure(this.message);
}

class AcceptOrdersLoading extends MapStates {}

class AcceptOrdersSuccess extends MapStates {}

class AcceptOrdersFailure extends MapStates {
  final String message;
  AcceptOrdersFailure(this.message);
}

class CompeleteOrdersLoading extends MapStates {}

class CompeleteOrdersSuccess extends MapStates {}

class CompeleteOrdersFailure extends MapStates {
  final String message;
  CompeleteOrdersFailure(this.message);
}

class GetAllCampLoading extends MapStates {}

class GetAllCampSuccess extends MapStates {}

class GetAllCampError extends MapStates {
  final String message;
  GetAllCampError(this.message);
}
