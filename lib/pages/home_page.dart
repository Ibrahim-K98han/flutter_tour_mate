import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../db/db_firestore_helper.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Tour List'),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset('images/tourbackground.jpg',width: double.infinity,
            height: double.infinity,fit: BoxFit.cover,),
          ),
          StreamBuilder(
            stream: DBFirestoreHelper.getAllTours(),
            builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
              if(snapshot.hasData){
                return ListView.builder(itemBuilder: null);
              }
              if(snapshot.hasError){
                return Center(child: Text('Failed to fetch data'),);
              }
              return Center(child: CircularProgressIndicator(),);
            }
          ),
        ],
      ),
    );
  }
}
