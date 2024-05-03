import 'package:cloud_firestore/cloud_firestore.dart';

class TextConfig {
  static const user = 'User';
  static const userSessionData = 'UserSessionData';
}

class CollectionUtils {
  static final userCollection =
      FirebaseFirestore.instance.collection(TextConfig.user);
  static final sessionCollection =
      FirebaseFirestore.instance.collection(TextConfig.userSessionData);
}
