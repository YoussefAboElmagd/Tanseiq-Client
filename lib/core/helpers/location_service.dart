import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<bool> checkAndRequestLocationService() async {
    var isServiceEnabled = await _location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await _location.requestService();
      if (!isServiceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }
    return true;
  }

  Future<LocationData?> getCurrentLocation() async {
    return await _location.getLocation();
  }

  Stream<LocationData> getLocationUpdates() {
    return _location.onLocationChanged;
  }
}
