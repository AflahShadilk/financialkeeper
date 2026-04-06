import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:financialkeeper/models/contribution_model.dart';
import 'package:financialkeeper/models/goal_model.dart';

class FirebaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String get userId => auth.currentUser?.uid ?? '';

  CollectionReference get userGoals =>
      db.collection('users').doc(userId).collection('goals');

  //create goal
  Future<void> createGoal(String title, double amount, DateTime deadline) async {
    if (userId.isEmpty) return;
    
    final doc = userGoals.doc();
    await doc.set({
      'title': title,
      'savedAmount': 0.0,
      'targetAmount': amount,
      'deadline': Timestamp.fromDate(deadline),
    });
  }

  //goal streaming
  Stream<List<GoalModel>> getGoals() {
    if (userId.isEmpty) return Stream.value([]);
    
    return userGoals.snapshots().map((snap) {
      return snap.docs.map((doc) {
        return GoalModel.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //contribution related -----------------------------

  Future<void> addContribution(String goalId, double amount, String note) async {
    if (userId.isEmpty) return;
    
    final goalRef = userGoals.doc(goalId);

    //add contribution
    await goalRef.collection('contributions').add({
      'amount': amount,
      'date': Timestamp.now(),
      'note': note,
    });

    //update saved amount
    final doc = await goalRef.get();
    final data = doc.data() as Map<String, dynamic>?;
    final currentSaved = (data?['savedAmount'] as num?)?.toDouble() ?? 0.0;
    
    await goalRef.update({
      'savedAmount': currentSaved + amount,
    });
  }

  //contribution streaming
  Stream<List<ContributionModel>> getContributions(String goalId) {
    if (userId.isEmpty) return Stream.value([]);
    
    return userGoals
        .doc(goalId)
        .collection('contributions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => ContributionModel.fromJson(doc.id, doc.data()))
            .toList());
  }

  //delete contribution
  Future<void> deleteContribution(String goalId, String contributionId, double amount) async {
    if (userId.isEmpty) return;
    
    final goalRef = userGoals.doc(goalId);

    await goalRef.collection('contributions').doc(contributionId).delete();
    
    final doc = await goalRef.get();
    final data = doc.data() as Map<String, dynamic>?;
    final currentSaved = (data?['savedAmount'] as num?)?.toDouble() ?? 0.0;
    
    await goalRef.update({
      'savedAmount': (currentSaved - amount).clamp(0, double.infinity),
    });
  }

  //update contribution
  Future<void> updateContribution(
      String goalId, String contributionId, double oldAmount, double newAmount, String newNote) async {
    if (userId.isEmpty) return;
    
    final goalRef = userGoals.doc(goalId);

    await goalRef.collection('contributions').doc(contributionId).update({
      'amount': newAmount,
      'note': newNote,
      'date': Timestamp.now(),
    });
    
    final doc = await goalRef.get();
    final data = doc.data() as Map<String, dynamic>?;
    final currentSaved = (data?['savedAmount'] as num?)?.toDouble() ?? 0.0;
    
    await goalRef.update({
      'savedAmount': (currentSaved - oldAmount + newAmount).clamp(0, double.infinity),
    });
  }
}
