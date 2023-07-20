import 'package:location/location.dart';

class LocationHelper {
  double latitude = 0.0;
  double longitude = 0.0;

  String get city => 'Denizli';

  Future<void> getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData? _locationData;

    // Location servisi etkin mi?
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Konum izni kontrolü
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }

    // İzinler tamam ise
    LocationData locationData = await location.getLocation();
    latitude = locationData.latitude!;
    longitude = locationData.longitude!;
  }
}
