import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/colors/colors.dart';
import 'package:flutter_tour_mate/providers/weather_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart' as Geo;

class WeatherPage extends StatefulWidget {
  static final routeName = '/weather';

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void didChangeDependencies() {
    _getDeviceLocation();
    // Provider.of<WeatherProvider>(context).getCurrentWeatherInfo();
    super.didChangeDependencies();
  }

  _getDeviceLocation() async {
    final position = await Geo.getLastKnownPosition();
    //print('${position.latitude},${position.longitude}');
    Provider.of<WeatherProvider>(context, listen: false)
        .getCurrentWeatherInfo(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Weather'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              'images/weather.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
