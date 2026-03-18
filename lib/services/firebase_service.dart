import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financialkeeper/models/contribution_model.dart';
import 'package:financialkeeper/models/goal_model.dart';

class FirebaseService {
  final _db = FirebaseFirestore.instance;
  //goal streaming
  Stream<GoalModel> getGoals() {
    return _db
        .collection('goals')
        .doc('goal_1')
        .snapshots()
        .map((snap) => GoalModel.fromJson(snap.data()!));
  }

  //contribution streaming
  Stream<List<ContributionModel>> getContributions() {
    return _db
        .collection('goals')
        .doc('goal_1')
        .collection('contributions')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => ContributionModel.fromJson(doc.data()))
            .toList());
  }
}
