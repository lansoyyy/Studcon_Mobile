import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Future addMessage(
  String course,
  String message,
  String name,
  String concern,
  String email,
  String receiverId,
) async {
  final docUser = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc(receiverId)
      .collection('Messages')
      .doc();

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'course': course,
    'message': message,
    'name': name,
    'email': email,
    'concern': concern,
    'time': tdata,
    'id': docUser.id,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}

Future addMessage2(
  String course,
  String message,
  String name,
  String concern,
  String email,
  String receiverId,
) async {
  final docUser = FirebaseFirestore.instance
      .collection(receiverId)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Messages')
      .doc();

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'course': course,
    'message': message,
    'name': name,
    'email': email,
    'concern': concern,
    'time': tdata,
    'id': docUser.id,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
