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
}
