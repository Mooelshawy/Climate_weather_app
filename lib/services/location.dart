import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getCurrentLocation() async {
    try {
      //first of all get request permission from user to access his location
      //create object form location permissin class
      LocationPermission permission;
      //check permission requested or not
      permission = await Geolocator.checkPermission();
      //make a decision requet denied or accepted
      //and handeled replay
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        //if request denied for ever mean user not want access
        if (permission == LocationPermission.deniedForever) {
          //return Future object with error
          return Future.error('Location Not Available');
        }
      }
      // else {
      //   //return exception to be handeled out thier here
      //   throw Exception('Error');
      // }
      //To query the current location of the device simply make a call
      //to the getCurrentPosition method.
      // You can finetune the results by specifying the following parameters:
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude;
      latitude = position.latitude;
    } catch (e) {
      print(e);
    }
  }
}
