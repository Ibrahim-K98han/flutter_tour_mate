import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/colors/colors.dart';
import 'package:flutter_tour_mate/db/db_firestore_helper.dart';
import 'package:flutter_tour_mate/models/toure_model.dart';
import 'package:flutter_tour_mate/pages/tour_details_page.dart';
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
    return Dismissible(
      key: ValueKey(widget.tourModel.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        margin: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
        color: Colors.red,
        child: Icon(Icons.delete,color: Colors.white,),
      ),
      onDismissed: (direction){
        DBFirestoreHelper.deleteTour(String, widget.tourModel.id);
      },
      confirmDismiss: (direction){
        return showDialog(
          context:context,
          builder: (context) => AlertDialog(
            title: Text('Delete ${widget.tourModel.tourName}?'),
            content: Text('Are you sure to delete this item? You cannot undo this operation'),
            actions: [
              TextButton(
                onPressed: ()=>Navigator.pop(context, false),
                child: Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('DELETE'),
              )
            ],
          )
        );
      },
      child: OpenContainer(
        closedColor: backgroundColor.withOpacity(0.0),
        closedElevation: 0,
        closedBuilder: (context,_)=>Card(
          margin: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: rowItemColor,
          elevation: 3,
          child: ListTile(
            title: Text('${widget.tourModel.tourName}',style: textHeadLineStyle,),
            subtitle: Text('${widget.tourModel.destination}', style: texSubtHeadLineStyle,),
          ),
        ),
        openBuilder: (context, _)=>TourDetailsPage(id: widget.tourModel.id!),
        transitionType: ContainerTransitionType.fade,
        transitionDuration: Duration(milliseconds: 700),
      )
    );
  }
}
