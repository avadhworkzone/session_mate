import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:session_mate/modal/add_service_data_model.dart';
import 'package:session_mate/modal/therapy_center_location_data_model.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';

class SessionService {
  /// add session data
  static Future<bool> addSessionData(AddSessionDataModel model) async {
    final doc = CollectionUtils.sessionCollection.doc();
    model.sessionId = doc.id;
    return doc.set(model.toJson()).then((value) => true).catchError((e) {
      print('SESSION ERROR :=>$e');
      return false;
    });
  }

  /// get session data
  static Stream<List<AddSessionDataModel>> getSessionData() {
    return CollectionUtils.sessionCollection
        .where('userId', isEqualTo: SharedPreferenceUtils.getUserId())
        .snapshots()
        .map((event) => event.docs
            .map((e) => AddSessionDataModel.fromJson(e.data()))
            .toList());
  }

  /// delete session data
  static Future<bool> deleteSessionData(String id) async {
    return CollectionUtils.sessionCollection
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((e) {
      print(' delete ERROR :=>$e');
      return false;
    });
  }

  /// get session data detail
  static Future<AddSessionDataModel> getEditSessionDataDetail() async {
    return await CollectionUtils.sessionCollection
        .doc(SharedPreferenceUtils.getSessionId())
        .get()
        .then((value) => AddSessionDataModel.fromJson(value.data()!))
        .catchError((e) {
      print('getSessionDataDetail error :=>$e');
      return null;
    });
  }

  /// get session count
  static Future<List<AddSessionDataModel>> fetchFilteredData(
      {required String sessionName, required String selectedMonth}) async {
    final snapshot = await CollectionUtils.sessionCollection
        .where('session_name', isEqualTo: sessionName)
        .where('session_month', isEqualTo: selectedMonth)
        .get(); // Filter for a single day
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return AddSessionDataModel.fromJson(data);
      }).toList();
    } else {
      return []; // Return an empty list if no data found
    }
  }

  /// add therapy center
  static Future<bool> addTherapyCenter(
      TherapyCenterLocationDataModel model) async {
    final doc = CollectionUtils.therapyCenterCollection.doc();
    model.locationId = doc.id;
    return doc.set(model.toJson()).then((value) => true).catchError((e) {
      print('SESSION ERROR :=>$e');
      return false;
    });
  }

  /// get therapy center
  static Stream<List<TherapyCenterLocationDataModel>>
      getTherapyCenterLocationData() {
    return CollectionUtils.therapyCenterCollection
        .where('userId', isEqualTo: SharedPreferenceUtils.getUserId())
        .snapshots()
        .map((event) => event.docs
            .map((e) => TherapyCenterLocationDataModel.fromJson(e.data()))
            .toList());
  }

  /// get therapy center for dropdown
  Future<List<TherapyCenterLocationDataModel>>
      getTherapyDropdownCenter() async {
    try {
      final snapshot = await CollectionUtils.therapyCenterCollection
          .where('userId', isEqualTo: SharedPreferenceUtils.getUserId())
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return TherapyCenterLocationDataModel.fromJson(data);
        }).toList();
      } else {
        return []; // Return an empty list if no data found
      }
    } catch (e) {
      print('get therapy center error :=>$e');
      throw e; // Rethrow the error to be handled elsewhere if needed
    }
  }

  /// delete therapy center
  static Future<bool> deleteTherapyCenterData(String id) async {
    return CollectionUtils.therapyCenterCollection
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((e) {
      print(' delete ERROR :=>$e');
      return false;
    });
  }
}
