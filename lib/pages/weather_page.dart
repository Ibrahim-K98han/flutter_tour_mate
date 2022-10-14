import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/colors/colors.dart';

class WeatherPage extends StatefulWidget {
  static final routeName = '/weather';

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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
