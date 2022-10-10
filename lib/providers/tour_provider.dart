import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/db/db_firestore_helper.dart';
import 'package:flutter_tour_mate/models/expence_model.dart';
import 'package:flutter_tour_mate/models/moment_model.dart';
import 'package:flutter_tour_mate/models/toure_model.dart';

class TourProvider with ChangeNotifier{
  List<ExpenceModel> _expenses = [];
  TourModel tourModel = TourModel();
  double totalExpense = 0.0;

  List<ExpenceModel> get expenseList => _expenses;

  Future<void> saveExpense(ExpenceModel expenceModel)async{
    await DBFirestoreHelper.addExpense(expenceModel);
  }
  Future<void> saveMoment(MomentModel momentModel)async{
    await DBFirestoreHelper.addMoment(momentModel);
  }

  Future<TourModel>fetchTourById(String tourId)async{
    tourModel = await DBFirestoreHelper.getTourById(String, tourId);
    notifyListeners();
    return tourModel;
  }
  //
  // void fetchExpense(String tourId){
  //   DBFirestoreHelper.getAllExpensesListFromDB(tourId).then((value){
  //     _expenses = value;
  //     _calculateTotalExpense();
  //     notifyListeners();
  //   });
  // }

  Stream<QuerySnapshot> getExpenses(String tourId){
    return DBFirestoreHelper.getAllExpenses(tourId);
  }

  void _calculateTotalExpense(){
    var total = 0.0;
    _expenses.forEach((element) {
      total += element.expenseAmount!;
    });
    totalExpense = total;
    notifyListeners();
  }

  double getExpensePercent()=>(totalExpense * 100) / tourModel.budget!;
}