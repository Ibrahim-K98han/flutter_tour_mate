import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/colors/colors.dart';
import 'package:flutter_tour_mate/db/db_firestore_helper.dart';
import 'package:flutter_tour_mate/style/text_styles.dart';
import 'package:flutter_tour_mate/utils/tour_utils.dart';

import '../models/toure_model.dart';

class TourDetailsPage extends StatefulWidget {
  static final routeName = '/tour_details';
  final String? id;

  TourDetailsPage({this.id});

  @override
  State<TourDetailsPage> createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              'images/tourbackground2.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 70,
            child: FutureBuilder(
              future: DBFirestoreHelper.getTourById(String, widget.id),
              builder: (context, AsyncSnapshot<TourModel> snapshot) {
                if (snapshot.hasData) {
                  return CustomScrollView(
                    slivers: [_buildSliverList(snapshot.data!)],
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to fetch data'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSliverList(TourModel tourModel) {
    return SliverList(
      delegate: SliverChildListDelegate([
        _tourDetailsSetion(tourModel),
      ]),
    );
  }

  Widget _tourDetailsSetion(TourModel tourModel) {
    return SizedBox(
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(10),
        color: rowItemColor,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    '${tourModel.tourName}',
                    style: textWhite16,
                  ),
                  Text(
                    'Starting on ${getFormatedDate(tourModel.startDate!, 'MMM dd')}',
                    style: textWhite14,
                  ),
                  Text(
                    'Going to ${tourModel.destination}',
                    style: textWhite14,
                  )
                ],
              ),
            ),
            Positioned(
              right: 10,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)
                    ),
                ),
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text('Complete Tour',style: textWhite16,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
