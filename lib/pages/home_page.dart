import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/models/toure_model.dart';
import 'package:flutter_tour_mate/pages/new_tour_page.dart';
import 'package:flutter_tour_mate/widgets/tour_item.dart';

import '../colors/colors.dart';
import '../db/db_firestore_helper.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

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
        title: const Text('Tour List'),
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
                return const Center(child: Text('Failed to fetch data'),);
              }
              return const Center(child: CircularProgressIndicator(),);
            }
          ),
        ],
      ),
      floatingActionButton: OpenContainer(
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 700),
        openBuilder: (context,_)=>NewTourPage(),
        closedBuilder: (context,_)=>const SizedBox(
          width: 60,
          height: 60,
          child: Icon(Icons.add,color: Colors.white,),
        ),
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        closedElevation: 7.0,
        closedColor: backgroundColor,
      )
    );
  }
}
