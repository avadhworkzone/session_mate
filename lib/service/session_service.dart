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
  /// get All Doctor
  static Stream<List<AddSessionDataModel>> getSessionData() {
    return CollectionUtils.sessionCollection
        .where('userId', isEqualTo: SharedPreferenceUtils.getUserId())
        .snapshots()
        .map((event) => event.docs
            .map((e) => AddSessionDataModel.fromJson(e.data()))
            .toList());
  }
}
