import 'package:cloud_firestore/cloud_firestore.dart';

class TextConfig {
  static const user = 'User';
  static const userSessionData = 'UserSessionData';
  static const therapyCenter = 'TherapyCenters';
  static const session = 'Session';
}

class CollectionUtils {
  static final userCollection =
      FirebaseFirestore.instance.collection(TextConfig.user);
  static final sessionCollection =
      FirebaseFirestore.instance.collection(TextConfig.userSessionData);
  static final therapyCenterCollection =
      FirebaseFirestore.instance.collection(TextConfig.therapyCenter);
  static final session =
      FirebaseFirestore.instance.collection(TextConfig.session);
}
