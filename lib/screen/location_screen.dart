import 'package:climate_app/services/weather.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel model = WeatherModel();

  late String weatherMain;
  late String weatherDescreption;
  late int weatherTemp;
  late String weatherIcon;
  late String cityName;
  late double temp ;
  late String weatherMessage;

  @override
  void initState() {
    // TODO: implement initState
    print('init State for Stateful widget');

    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(weatherData) {
    setState(() {
      if (weatherData == null) {
        weatherMain = '';
        weatherIcon = '';
        weatherDescreption = ' ';
        temp= 0.0 ;
        cityName = '';
        return;
      }
      weatherMain = weatherData['weather'][0]['main'];
      var weatherCondtion = weatherData['weather'][0]['id'];
      weatherIcon = model.getWeatherIcon(weatherCondtion);
      weatherDescreption = weatherData['weather'][0]['description'];
      temp = weatherData['main']['temp_max'];
      weatherTemp = temp.toInt();
      cityName = weatherData['name'];

      weatherMessage = model.getMessage(weatherTemp);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('did change dependaencies for stateful widget');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant LocationScreen oldWidget) {
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0)),
                      elevation: MaterialStateProperty.all(10.0),
                    ),
                    onPressed: () async {
                      var weatherDataNewLoation =
                          await model.getLocationWeather();
                      updateUI(weatherDataNewLoation);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0)),
                      elevation: MaterialStateProperty.all(10.0),
                    ),
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData = await model.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${weatherTemp.round()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kTempTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
