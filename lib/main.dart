import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/pages/home_page.dart';
import 'package:flutter_tour_mate/pages/launcher_page.dart';
import 'package:flutter_tour_mate/pages/login_page.dart';
import 'package:flutter_tour_mate/pages/new_tour_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.transparent
        ),
        primarySwatch: Colors.blue,
      ),
      home: LauncherPage(),
      routes: {
        LauncherPage.routeName : (context) => LauncherPage(),
        LoginPage.routeName : (context) => LoginPage(),
        HomePage.routeName : (context) => HomePage(),
        NewTourPage.routeName : (context) => NewTourPage(),
      },
    );
  }
}
