import 'package:session_mate/modal/add_session_data_model.dart';
import 'package:session_mate/modal/get_session_list_model.dart';
import 'package:session_mate/modal/therapy_center_location_data_model.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';

class SessionService {
  /// ADD SESSION DATA
  static Future<bool> addSessionData(AddSessionDataModel model) async {
    final doc = CollectionUtils.sessionCollection.doc();
    model.id = doc.id;
    return doc.set(model.toJson()).then((value) => true).catchError((e) {
      logs('SESSION ERROR :=>$e');
      return false;
    });
  }

  /// GET SESSION DATA
  static Stream<List<AddSessionDataModel>> getSessionData() {
    return CollectionUtils.sessionCollection
        .where('userId', isEqualTo: SharedPreferenceUtils.getUserId())
        .snapshots()
        .map((event) => event.docs
            .map((e) => AddSessionDataModel.fromJson(e.data()))
            .toList());
  }

  /// DELETE SESSION DATA
  static Future<bool> deleteSessionData(String id) async {
    return CollectionUtils.sessionCollection
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((e) {
      logs(' delete ERROR :=>$e');
      return false;
    });
  }

  /// GET SESSION DATA DETAIL
  static Future<AddSessionDataModel> getEditSessionDataDetail() async {
    return await CollectionUtils.sessionCollection
        .doc(SharedPreferenceUtils.getSessionId())
        .get()
        .then((value) => AddSessionDataModel.fromJson(value.data()!))
        .catchError((e) {
      logs('getSessionDataDetail error :=>$e');
      return null;
    });
  }

  /// GET SESSION COUNT
  static Future<List<AddSessionDataModel>> getSessionCount(
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

  /// ADD THERAPY CENTER
  static Future<bool> addTherapyCenter(
      TherapyCenterLocationDataModel model) async {
    final doc = CollectionUtils.therapyCenterCollection.doc();
    model.locationId = doc.id;
    return doc.set(model.toJson()).then((value) => true).catchError((e) {
      logs('SESSION ERROR :=>$e');
      return false;
    });
  }

  /// GET THERAPY CENTER
  static Stream<List<TherapyCenterLocationDataModel>>
      getTherapyCenterLocationData() {
    return CollectionUtils.therapyCenterCollection
        .where('userId', isEqualTo: SharedPreferenceUtils.getUserId())
        .snapshots()
        .map((event) => event.docs
            .map((e) => TherapyCenterLocationDataModel.fromJson(e.data()))
            .toList());
  }

  /// GET THERAPY CENTER FOR DROP DOWN LIST
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
      logs('get therapy center error :=>$e');
      throw e;
    }
  }

  /// DELETE THERAPY CENTER
  static Future<bool> deleteTherapyCenterData(String id) async {
    return CollectionUtils.therapyCenterCollection
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((e) {
      logs(' delete ERROR :=>$e');
      return false;
    });
  }

  /// GET SESSION LIST
  static Stream<List<SessionListData>> getSessionList() {
    return CollectionUtils.session.snapshots().map((event) =>
        event.docs.map((e) => SessionListData.fromJson(e.data())).toList());
  }
}
