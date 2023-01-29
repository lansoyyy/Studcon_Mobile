import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addCodeAndSection(
    String course, String classCode, String section) async {
  final docUser =
      FirebaseFirestore.instance.collection('Code&Section').doc(classCode);

  final json = {
    'classCode': classCode,
    'id': FirebaseAuth.instance.currentUser!.uid
  };

  await docUser.set(json);
}
