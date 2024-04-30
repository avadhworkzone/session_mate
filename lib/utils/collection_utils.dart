import 'package:cloud_firestore/cloud_firestore.dart';

class TextConfig {
  static const user = 'User';
}

class CollectionUtils {
  static final userCollection =
      FirebaseFirestore.instance.collection(TextConfig.user);
}
