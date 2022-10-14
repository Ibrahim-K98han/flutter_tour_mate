// @dart=2.0
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/pages/home_page.dart';
import 'package:flutter_tour_mate/pages/launcher_page.dart';
import 'package:flutter_tour_mate/pages/login_page.dart';
import 'package:flutter_tour_mate/pages/new_tour_page.dart';
import 'package:flutter_tour_mate/pages/tour_details_page.dart';
import 'package:flutter_tour_mate/pages/weather_page.dart';
import 'package:flutter_tour_mate/providers/tour_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>TourProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Colors.transparent
          ),
          primarySwatch: Colors.blue,
        ),
        home: LauncherPage(),
        routes: {
          LauncherPage.routeName : (context) => LauncherPage(),
          LoginPage.routeName : (context) => LoginPage(),
          HomePage.routeName : (context) => const HomePage(),
          NewTourPage.routeName : (context) => NewTourPage(),
          TourDetailsPage.routeName : (context) => TourDetailsPage(),
          WeatherPage.routeName : (context) => WeatherPage(),
        },
      ),
    );
  }
}
