import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/models/moment_model.dart';

class MomentGridItem extends StatefulWidget {
  final MomentModel momentModel;

  MomentGridItem(this.momentModel);

  @override
  State<MomentGridItem> createState() => _MomentGridItemState();
}

class _MomentGridItemState extends State<MomentGridItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(2.0),
      elevation: 1,
      child: FadeInImage.assetNetwork(
          fadeInDuration: Duration(milliseconds: 1000),
          fadeInCurve: Curves.bounceIn,
          placeholder: 'images/placeholder.jpg',
          image: '${widget.momentModel.imageDownloadUrl}',
          fit: BoxFit.cover,
      ),
    );
  }
}
