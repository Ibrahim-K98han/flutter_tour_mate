import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/models/toure_model.dart';
import 'package:flutter_tour_mate/pages/new_tour_page.dart';
import 'package:flutter_tour_mate/widgets/tour_item.dart';

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
            builder: (context, AsyncSnapshot<dynamic>snapshot){
              if(snapshot.hasData){
                return ListView.builder(itemBuilder: (context, index)=>
                    TourItem(TourModel.fromMap(snapshot.data.docs[index].data())),
                  itemCount: snapshot.data.docs.length,
                );
              }
              if(snapshot.hasError){
                return Center(child: Text('Failed to fetch data'),);
              }
              return Center(child: CircularProgressIndicator(),);
            }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.pushNamed(context, NewTourPage.routeName),
      ),
    );
  }
}
