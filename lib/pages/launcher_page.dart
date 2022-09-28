import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/auth/firebase_authentication.dart';
import 'package:flutter_tour_mate/pages/home_page.dart';
import 'package:flutter_tour_mate/pages/login_page.dart';

class LauncherPage extends StatefulWidget {
  static final routeName = '/launcher';

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  late FirebaseAuthenticationService authenticationService;

  @override
  void initState() {
    authenticationService = FirebaseAuthenticationService();
   Future.delayed(Duration.zero, (){
     authenticationService.currentUser == null
         ? Navigator.pushReplacementNamed(context, LoginPage.routeName)
         : Navigator.pushReplacementNamed(context, HomePage.routeName);
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
