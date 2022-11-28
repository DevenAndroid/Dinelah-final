

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GPS extends StatefulWidget{
  @override
  GpsState createState() => GpsState();
}

class GpsState extends State<GPS> {

  bool servicestatus = false;
  bool haspermission = false;

  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";

  late StreamSubscription<Position> positionStream;

  checkGps() async {

    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        // setState(() {
        //   //refresh the UI
        // });

        getLocation();
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              "Location",
            ),
            content: const Text(
              "Please turn on GPS location service to narrow down the nearest eateries.",
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Geolocator.openLocationSettings();
                  servicestatus =
                  await Geolocator.isLocationServiceEnabled();
                  if (servicestatus) {
                    permission = await Geolocator.checkPermission();

                    if (permission == LocationPermission.denied) {
                      permission = await Geolocator.requestPermission();
                      if (permission == LocationPermission.denied) {
                        print('Location permissions are denied');
                      } else if (permission ==
                          LocationPermission.deniedForever) {
                        print(
                            "Location permissions are permanently denied");
                      } else {
                        haspermission = true;
                      }
                    } else {
                      haspermission = true;
                    }

                    if (haspermission) {
                      setState(() {
                        //refresh the UI
                      });

                      getLocation();
                    }
                  }
                },
              ),
            ],
          ));

      print("GPS Service is not enabled, turn on GPS location");
    }

    // setState(() {
    //   //refresh the UI
    // });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('latitude', lat.toString());
    prefs.setString('longitude', long.toString());
    // setState(() {
    //   //refresh UI
    // });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    // StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      // setState(() {
        // print('Latitude :: ' +
        //     position.longitude.toString()); //Output: 80.24599079
        // print('Longitude :: ' +
        //     position.latitude.toString()); //Output: 29.6593457

        //refresh UI on update
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}