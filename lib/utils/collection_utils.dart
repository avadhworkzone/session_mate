<<<<<<< Updated upstream
import 'package:cloud_firestore/cloud_firestore.dart';

class TextConfig {
  static const user = 'User';
  static const userSessionData = 'UserSessionData';
  static const therapyCenter = 'TherapyCenters';
  static const session = 'Session';
  static const ageGroupLevel = 'AgeLevel';
  static const goalCategory = 'Goal';
  static const goalSubCategory = 'subGoal';
  static const currentLevel = 'Current Level';
  static const strategies = 'Strategies';
  static const userTherapyData = 'userTherapyData';
  static const therapyCenterCode = 'therapyCenterCode';
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
  static final ageGroupLevel =
      FirebaseFirestore.instance.collection(TextConfig.ageGroupLevel);
  static final goalCategoryCollection =
      FirebaseFirestore.instance.collection(TextConfig.goalCategory);
  static final goalSubCategoryCollection =
      FirebaseFirestore.instance.collection(TextConfig.goalSubCategory);
  static final currentLevelCollection =
      FirebaseFirestore.instance.collection(TextConfig.currentLevel);
  static final strategiesCollection =
      FirebaseFirestore.instance.collection(TextConfig.strategies);
  static final userTherapyDataCollection =
      FirebaseFirestore.instance.collection(TextConfig.userTherapyData);
  static final therapyCenterCodeCollection =
      FirebaseFirestore.instance.collection(TextConfig.therapyCenterCode);
}
=======
import 'package:cloud_firestore/cloud_firestore.dart';

class TextConfig {
  static const user = 'User';
  static const userSessionData = 'UserSessionData';
  static const therapyCenter = 'TherapyCenters';
  static const session = 'Session';
  static const ageGroupLevel = 'AgeLevel';
  static const goalCategory = 'Goal';
  static const goalSubCategory = 'subGoal';
  static const currentLevel = 'Current Level';
  static const strategies = 'Strategies';
  static const userTherapyData = 'userTherapyData';
  static const therapyCenterCode = 'therapyCenterCode';
}

class CollectionUtils {
  static final userCollection = FirebaseFirestore.instance.collection(TextConfig.user);
  static final sessionCollection =
      FirebaseFirestore.instance.collection(TextConfig.userSessionData);
  static final therapyCenterCollection = FirebaseFirestore.instance.collection(TextConfig.therapyCenter);
  static final session =
      FirebaseFirestore.instance.collection(TextConfig.session);
  static final ageGroupLevel =
      FirebaseFirestore.instance.collection(TextConfig.ageGroupLevel);
  static final goalCategoryCollection =
      FirebaseFirestore.instance.collection(TextConfig.goalCategory);
  static final goalSubCategoryCollection =
      FirebaseFirestore.instance.collection(TextConfig.goalSubCategory);
  static final currentLevelCollection =
      FirebaseFirestore.instance.collection(TextConfig.currentLevel);
  static final strategiesCollection =
      FirebaseFirestore.instance.collection(TextConfig.strategies);
  static final userTherapyDataCollection =
      FirebaseFirestore.instance.collection(TextConfig.userTherapyData);
  static final therapyCenterCodeCollection =
      FirebaseFirestore.instance.collection(TextConfig.therapyCenterCode);
}
>>>>>>> Stashed changes
