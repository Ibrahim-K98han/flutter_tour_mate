import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tour_mate/models/toure_model.dart';

class DBFirestoreHelper {
  static final COLLECTION_TOUR = 'Tours';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addTour(TourModel tourModel) async {
    final doc = _db.collection(COLLECTION_TOUR).doc();
    tourModel.id = doc.id;
    return doc.set(tourModel.toMap());
  }

  static Stream<QuerySnapshot> getAllTours(){
    return _db.collection(COLLECTION_TOUR).snapshots();
  }

  static Future deleteTour(String, id)async{
    await _db.collection(COLLECTION_TOUR).doc(id).delete();
  }

  static Future<TourModel> getTourById(String, id)async{
    final snapshot = await _db.collection(COLLECTION_TOUR).doc(id).get();
    return TourModel.fromMap(snapshot.data()!);
  }
}
