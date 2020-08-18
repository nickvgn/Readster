import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final int dailyGoal, yearlyGoal, finishedBooks;
  final List<dynamic> weeklyReadCount;

  User(
      {this.uid,
      this.dailyGoal,
      this.yearlyGoal,
      this.weeklyReadCount,
      this.finishedBooks});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map user = doc.data;
    return User(
      uid: user['uid'],
      dailyGoal: user['dailyGoal'] ?? 0,
      yearlyGoal: user['yearlyGoal'] ?? 0,
      weeklyReadCount: user['weeklyReadCount'] ?? [0, 0, 0, 0, 0, 0, 0],
      finishedBooks: user['booksFinished${DateTime.now().year}'] ?? 0,
    );
  }
}
