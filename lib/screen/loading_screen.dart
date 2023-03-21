import 'dart:convert';

import 'package:climate_app/screen/location_screen.dart';
import 'package:climate_app/services/location.dart';
import 'package:climate_app/services/network_helper.dart';
import 'package:climate_app/services/weather.dart';
import 'package:climate_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../show_case.dart';
import '../work_space.dart';

const apiKey = '578abbb3d3baedda1ce7c8b67c726010';
Location location = Location();

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //this function for get user location
  //return Postion Object
  void getLocation() async {
    
    var weatherData = await WeatherModel().getLocationWeather() ;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LocationScreen(
                locationWeather: weatherData,
              )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    print('init State for Stateful widget');
    getLocation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('did change dependaencies for stateful widget');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant LoadingScreen oldWidget) {
    // TODO: implement didUpdateWidget
    print('did update widget for stateful widget ');

    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    print('deactivate for state ful widget');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              child: LayoutBuilder(
                builder: (context, _) {
                  return IconButton(
                    icon: Icon(Icons.play_circle_filled),
                    iconSize: 50.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => ShowCase(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  );
                },
              ),
              alignment: Alignment.bottomCenter,
            ),
            Positioned.fill(
              child: Center(
                child: WorkSpace(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
