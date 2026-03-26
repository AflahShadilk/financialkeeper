import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financialkeeper/models/contribution_model.dart';
import 'package:financialkeeper/models/goal_model.dart';

class FirebaseService {
  final _db = FirebaseFirestore.instance;
  
  //add goal
  Future<void>createGoal(String title, double amount, DateTime deadline) async {
    await _db.collection('goals').doc('goal_1').set({
      'title': title,
      'savedAmount': 0.0,
      'targetAmount': amount,
      'deadline': deadline,
    });
  }


  //goal streaming
  Stream<GoalModel?> getGoals() {
  return _db.collection('goals').doc('goal_1').snapshots().map((doc) {
    final data = doc.data();

    if (data == null) {
      return null; 
    }

    return GoalModel.fromJson(data);
  });
}

  //contribution related -----------------------------

    Future<void>addContribution(double amount) async {
    final goalr= _db.collection('goals').doc('goal_1');

    //add contribution
    await goalr.collection('contributions').add({
      'amount':amount,
      'date':Timestamp.now(),
    });

    //update saved amount
    final doc= await goalr.get();
    final currentSaved= doc.data()?['savedAmount']??0;
    await goalr.update({
      'savedAmount': currentSaved + amount,
    });
  }
  //contribution streaming
  Stream<List<ContributionModel>> getContributions() {
    return _db
        .collection('goals')
        .doc('goal_1')
        .collection('contributions').orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => ContributionModel.fromJson(doc.id,doc.data()))
            .toList());
  }
//delete contribution
  Future<void> deleteContribution(String id, double amount)async{
    final goalref = _db.collection('goals').doc('goal_1');

    await goalref.collection('contributions').doc(id).delete();
    final doc= await goalref.get();
    final currentSaved= doc.data()?['savedAmount']??0;
    await goalref.update({
      'savedAmount': (currentSaved - amount).clamp(0, double.infinity),
    });
  }

  //update contribution
  Future<void> updateContribution(String id, double oldAmount, double newAmount)async{
    final goalRef =_db.collection('goals').doc('goal_1');

    await goalRef.collection('contributions').doc(id).update({
      'amount': newAmount,
      'date': Timestamp.now(),
    });
    final doc = await goalRef.get();
    final current= doc.data()?['savedAmount']??0;
    await goalRef.update({
      'savedAmount': (current - oldAmount + newAmount).clamp(0, double.infinity),
    });
  }
}
