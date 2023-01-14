import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addSection(
  String section,
) async {
  final docUser = FirebaseFirestore.instance.collection('Section').doc(section);

  final json = {
    'section': section,
  };

  await docUser.set(json);
}
