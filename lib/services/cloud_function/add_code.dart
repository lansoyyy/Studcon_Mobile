import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addCode(
  String classCode,
) async {
  final docUser =
      FirebaseFirestore.instance.collection('Class Code').doc(classCode);

  final json = {
    'classCode': classCode,
  };

  await docUser.set(json);
}
