import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:session_mate/modal/add_service_data_model.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';

class SessionService {
  /// add session data
  static Future<bool> addAppointmentData(AddSessionDataModel model) async {
    final doc = CollectionUtils.sessionCollection.doc();
    model.sessionId = doc.id;
    return doc.set(model.toJson()).then((value) => true).catchError((e) {
      print('APPOINTMENT ERROR :=>$e');
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
  // ///get  doctor detail
  // static Future<DoctorDetailResponseModel?> getDoctorDetail() async {
  //   return await CollectionUtils.doctorCollection
  //       .doc(PreferenceManagerUtils.getDoctorId())
  //       .get()
  //       .then((value) => DoctorDetailResponseModel.fromJson(value.data()!))
  //       .catchError((e) {
  //     print('getPatientDetail error :=>$e');
  //     return null;
  //   });
  // }
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

  Future<int> fetchFilteredDataCount(
      String sessionName, int selectedDate) async {
    // Create a reference to your Firestore collection
    CollectionReference sessionsRef =
        FirebaseFirestore.instance.collection('UserSessionData');

    // Construct a query to filter documents based on session name and selected date
    Query query = sessionsRef
        .where('session_name', isEqualTo: sessionName)
        .where('session_date',
            isGreaterThanOrEqualTo:
                DateTime(2024, selectedDate, 1)); // Filter for a single day

    // Fetch documents that match the query
    QuerySnapshot querySnapshot = await query.get();

    // Return the count of documents fetched
    return querySnapshot.docs.length;
  }
}
