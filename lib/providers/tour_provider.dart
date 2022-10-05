import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/db/db_firestore_helper.dart';
import 'package:flutter_tour_mate/models/expence_model.dart';
import 'package:flutter_tour_mate/models/toure_model.dart';

class TourProvider with ChangeNotifier{
  List<ExpenceModel> _expenses = [];
  TourModel tourModel = TourModel();

  List<ExpenceModel> get expenseList => _expenses;

  Future<void> saveExpense(ExpenceModel expenceModel)async{
    await DBFirestoreHelper.addExpense(expenceModel);
  }

  Stream<QuerySnapshot> getExpenses(String tourId){
    return DBFirestoreHelper.getAllExpenses(tourId);
  }

}