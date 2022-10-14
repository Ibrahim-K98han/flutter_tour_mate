import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/colors/colors.dart';
import 'package:flutter_tour_mate/pages/weather_page.dart';
import 'package:flutter_tour_mate/style/text_styles.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
        color: backgroundColor,
        child: Column(
          children: [
            buildHeaderContainer(),
            ListTile(
              onTap: () => Navigator.pushNamed(context, WeatherPage.routeName),
              leading: Icon(Icons.wb_cloudy),
              title: Text('Weather',style: textWhite22,),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.near_me),
              title: Text('Nearby',style: textWhite22,),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeaderContainer() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      color: rowItemColor,
      child: RichText(
        text: TextSpan(
          text: 'T',
          style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: backgroundColor),
          children: [
            TextSpan(text: 'our', style: TextStyle(fontWeight: FontWeight.normal,color: Colors.white)),
            TextSpan(text: 'M', ),
            TextSpan(text: 'ate', style: TextStyle(fontWeight: FontWeight.normal,color: Colors.white)),
          ]
        ),
      ),
    );
  }
}
