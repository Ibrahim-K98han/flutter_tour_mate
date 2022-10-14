import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tour_mate/models/expence_model.dart';
import 'package:flutter_tour_mate/models/moment_model.dart';
import 'package:flutter_tour_mate/models/toure_model.dart';

class DBFirestoreHelper {
  static final COLLECTION_TOUR = 'Tours';
  static final COLLECTION_EXPENCE = 'Expenses';
  static final COLLECTION_MOMENT = 'Moments';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addTour(TourModel tourModel) async {
    final doc = _db.collection(COLLECTION_TOUR).doc();
    tourModel.id = doc.id;
    return doc.set(tourModel.toMap());
  }

  static Future<void> addExpense(ExpenceModel expenceModel) async {
    final doc = _db.collection(COLLECTION_EXPENCE).doc();
    expenceModel.expenseId = doc.id;
    return doc.set(expenceModel.toMap());
  }

  static Future<void> addMoment(MomentModel momentModel) async {
    final doc = _db.collection(COLLECTION_MOMENT).doc();
    momentModel.momentId = doc.id;
    return doc.set(momentModel.toMap());
  }

  static Stream<QuerySnapshot> getAllTours(){
    return _db.collection(COLLECTION_TOUR).snapshots();
  }

  static Stream<QuerySnapshot> getAllExpenses(String tourId){
    return _db.collection(COLLECTION_EXPENCE).where('tourId',isEqualTo:tourId).snapshots();
  }


  static Future<List<MomentModel>>getMomentsListFromDB(String tourId)async{
    List<MomentModel> moments = [];
    final querySnapshot = await _db.collection(COLLECTION_MOMENT).where('tourId',isEqualTo:tourId).get();
    if(querySnapshot != null){
      moments = querySnapshot.docs.map((document) => MomentModel.fromMap(document.data())).toList();
    }
    return moments;
  }

  static Future<List<ExpenceModel>>getAllExpensesListFromDB(String tourId)async{
    List<ExpenceModel> expense = [];
    final querySnapshot = await _db.collection(COLLECTION_EXPENCE).where('tourId',isEqualTo:tourId).get();
    if(querySnapshot != null){
      expense = querySnapshot.docs.map((document) => ExpenceModel.fromMap(document.data())).toList();
  }
    return expense;
}

  static Future deleteTour(String, id)async{
    await _db.collection(COLLECTION_TOUR).doc(id).delete();
  }

  static Future<TourModel> getTourById(String, id)async{
    final snapshot = await _db.collection(COLLECTION_TOUR).doc(id).get();
    return TourModel.fromMap(snapshot.data()!);
  }
}
