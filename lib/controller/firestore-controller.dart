import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/weekday-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/models/user.dart';
import 'package:untitled_goodreads_project/services/auth.dart';
import 'package:intl/intl.dart';

class FirestoreController extends ChangeNotifier {
  static Firestore db = Firestore.instance;
  bool isAdded = false;

  static Stream<List<Book>> streamBooks(String uid) {
    var ref = db.collection('books').where('uid', isEqualTo: uid);
    return ref.snapshots().map(
          (list) =>
              list.documents.map((doc) => Book.fromFirestore(doc)).toList(),
        );
  }

  static Stream<User> streamUserData(String uid) {
    var ref = db.collection('user').where('uid', isEqualTo: uid);
    return ref
        .snapshots()
        .map((doc) => User.fromFirestore(doc.documents.first));
  }

  static Stream<List<Book>> streamBooksByStatus(String uid, String status) {
    var ref = db
        .collection('books')
        .where('uid', isEqualTo: uid)
        .where('readStatus', isEqualTo: status);
    return ref.snapshots().map(
          (list) =>
              list.documents.map((doc) => Book.fromFirestore(doc)).toList(),
        );
  }

  Future<int> setReadCountByDate(int day) async {
    DocumentSnapshot userToUpdate = await _getUserDocument();

    DateTime startTime = WeekdayController().getStartTime(day);
    DateTime endTime = WeekdayController().getEndTime(day);

    int count = 0;
    var temp;

    await db
        .collection('user')
        .document(userToUpdate.documentID)
        .collection('readTimestamp')
        .where('timeRead', isLessThanOrEqualTo: endTime)
        .where('timeRead', isGreaterThan: startTime)
        .snapshots()
        .first
        .then((value) {
      temp = value.documents;
    });

    for (var val in temp) {
      if (val['pagesRead'] != null) {
        count = count + val['pagesRead'] as int ?? 0;
      }
    }
    notifyListeners();

    return count;
  }

  Future<void> setReadCountList() async {
    List<int> list = [];

    list.add(await setReadCountByDate(1));
    list.add(await setReadCountByDate(2));
    list.add(await setReadCountByDate(3));
    list.add(await setReadCountByDate(4));
    list.add(await setReadCountByDate(5));
    list.add(await setReadCountByDate(6));
    list.add(await setReadCountByDate(7));

    DocumentSnapshot userToUpdate = await _getUserDocument();
    await db
        .collection('user')
        .document(userToUpdate.documentID)
        .updateData({'weeklyReadCount': list});

    notifyListeners();
  }

  Future<bool> checkIfAdded(String id) async {
    var ref = await db
        .collection('books')
        .where("id", isEqualTo: id)
        .snapshots()
        .first
        .then((value) => value.documents.length);

    notifyListeners();

    return ref == 0 ? false : true;
  }

  Future<void> addBook(Book book) async {
    var uid = await AuthService().getUserId;
    await db.collection('books').add({
      'id': book.id,
      'title': book.title,
      'author': book.author,
      'imageUrl': book.imageUrl,
      'isbn': book.isbn,
      'pageCount': book.pageCount,
      'pageRead': 0,
      'readStatus': TOREAD,
      'isGoodreads': false,
      'uid': uid,
    });
    notifyListeners();
  }

  static Future<DocumentSnapshot> _getDocument(Book book) async {
    QuerySnapshot items = await db.collection('books').getDocuments();

    for (var item in items.documents) {
      final id = item.data['id'];
      if (id.toString() == book.id) {
        return item;
      }
    }
    return null;
  }

  static Future<DocumentSnapshot> _getUserDocument() async {
    var uid = await AuthService().getUserId;
    QuerySnapshot items = await db.collection('user').getDocuments();

    for (var item in items.documents) {
      final id = item.data['uid'];
      if (id.toString() == uid) {
        return item;
      }
    }
    return null;
  }

  void deleteBook(Book book) async {
    DocumentSnapshot bookToDelete = await _getDocument(book);
    await db.collection('books').document(bookToDelete.documentID).delete();
    notifyListeners();
  }

  void updateBookStatus(String readStatus, Book book) async {
    DocumentSnapshot bookToUpdate = await _getDocument(book);
    await db
        .collection('books')
        .document(bookToUpdate.documentID)
        .updateData({'readStatus': readStatus});

    if (readStatus == READ) {
      addFinishedReadingDate(readStatus, book);
    }

    notifyListeners();
  }

  void addFinishedReadingDate(String readStatus, Book book) async {
    DocumentSnapshot bookToUpdate = await _getDocument(book);
    DocumentSnapshot userToUpdate = await _getUserDocument();

    var temp;

    await db
        .collection('user')
        .document(userToUpdate.documentID)
        .snapshots()
        .first
        .then((value) {
      temp = value.data['booksFinished${DateTime.now().year}'];
    });

    await db.collection('user').document(userToUpdate.documentID).updateData(
        {'booksFinished${DateTime.now().year}': temp == null ? 1 : (temp + 1)});

    await db
        .collection('books')
        .document(bookToUpdate.documentID)
        .updateData({'finishedDate': DateTime.now()});

    notifyListeners();
  }

  void updateFinishedPages(int pageRead, Book book) async {
    DocumentSnapshot bookToUpdate = await _getDocument(book);
    print("PREVIOUS PAGE: ${bookToUpdate['pageRead']}");
    print("CURRENT PAGE: ${pageRead}");
    print("DIFFERENCE: ${pageRead - bookToUpdate['pageRead']} ");

    addReadTimestamp(pageRead - bookToUpdate['pageRead'], book.id);

    await db.collection('books').document(bookToUpdate.documentID).updateData({
      'pageRead': pageRead,
      'lastRead': DateTime.now(),
    });

    notifyListeners();
  }

  void addReadTimestamp(int pagesRead, String bookId) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse("2020-08-19 8:40:23");

    DocumentSnapshot userToUpdate = await _getUserDocument();
    await db
        .collection('user')
        .document(userToUpdate.documentID)
        .collection('readTimestamp')
        .add({
      'pagesRead': pagesRead,
      'bookId': bookId,
      'timeRead': DateTime.now(),
    });
    setReadCountList();
    notifyListeners();
  }
}
