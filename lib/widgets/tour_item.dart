import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/colors/colors.dart';
import 'package:flutter_tour_mate/models/toure_model.dart';
import 'package:flutter_tour_mate/style/text_styles.dart';

class TourItem extends StatefulWidget {
  final TourModel tourModel;
  const TourItem(this.tourModel);

  @override
  State<TourItem> createState() => _TourItemState();
}

class _TourItemState extends State<TourItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: rowItemColor,
      elevation: 5,
      child: ListTile(
        title: Text('${widget.tourModel.tourName}',style: textHeadLineStyle,),
        subtitle: Text('${widget.tourModel.destination}', style: texSubtHeadLineStyle,),
      ),
    );
  }
}
