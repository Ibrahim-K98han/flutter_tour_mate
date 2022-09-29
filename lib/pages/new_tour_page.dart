import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/colors/colors.dart';
import 'package:flutter_tour_mate/db/db_firestore_helper.dart';
import 'package:flutter_tour_mate/models/toure_model.dart';
import 'package:intl/intl.dart';

import '../style/text_styles.dart';

class NewTourPage extends StatefulWidget {
  static final routeName = '/new_tour';

  @override
  State<NewTourPage> createState() => _NewTourPageState();
}

class _NewTourPageState extends State<NewTourPage> {
  final _formKey = GlobalKey<FormState>();
  TourModel tourModel = TourModel();
  DateTime? selectedDate;

  _openCalender() {
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040)
    ).then((dateTime){
      tourModel.startDate = dateTime!.microsecondsSinceEpoch;
      setState(() {
        selectedDate = dateTime;
      });
    });
  }
  _save(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      if(tourModel.startDate == null)return;
      DBFirestoreHelper.addTour(tourModel).then((_) => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('New Tour'),
      ),
      body: Stack(
        children: [
          Opacity(opacity: 0.4,
            child: Image.asset(
              'images/tourbackground2.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: 'Tour Name',
                        labelStyle: textWhite14,
                        filled: true,
                        fillColor: rowItemColor,
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name should not be empty';
                      }
                      if (value.length < 6) {
                        return 'Name cannot be less than 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      tourModel.tourName = value;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Enter Budget',
                        labelStyle: textWhite14,
                        filled: true,
                        fillColor: rowItemColor,
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Budget should not be empty';
                      }
                      if (double.parse(value) <= 0.0) {
                        return 'Budget should be greater than zero';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      tourModel.budget = double.parse(value!);
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: 'Enter Destination',
                        labelStyle: textWhite14,
                        filled: true,
                        fillColor: rowItemColor,
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Destination should not be empty';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      tourModel.destination = value;
                    },
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(selectedDate == null ?'Select a Starting Date':
                      DateFormat('EEE MMM dd, yyyy').format(selectedDate!),style: textWhite16),
                      ElevatedButton(
                        child: Text('Open Calender', style: textWhite14,),
                        onPressed: _openCalender,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey, // Background color
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        elevation: 5,
                        textStyle: TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text('Create New Tour'),
                      onPressed: _save,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
