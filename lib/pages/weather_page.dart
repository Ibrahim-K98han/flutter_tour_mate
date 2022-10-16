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
  bool isLoading = true;
  @override
  void didChangeDependencies() {
    _getDeviceLocation();
    super.didChangeDependencies();
  }

  _getDeviceLocation() async {
    final position = await Geo.getLastKnownPosition();
    Provider.of<WeatherProvider>(context, listen: false)
        .getCurrentWeatherInfo(position).
    then((_){
      setState(() {
        isLoading = false;
      });
    });
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
          ),
          Center(
            child: LayoutBuilder(
              builder: (context,constraint)=>Consumer<WeatherProvider>(
                builder: (context,provider, _)=>
                isLoading ? CircularProgressIndicator():
                constraint.maxWidth > 600 ?
                Row():
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100,),
                    Expanded(
                      child: _buildCurrenstSction(provider))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCurrenstSction(WeatherProvider provider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${provider.currentData.name},${provider.currentData.sys.country}'),
      ],
    );
  }
}
