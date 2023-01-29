import 'package:cloud_firestore/cloud_firestore.dart';

Future addCode(String classCode, String course) async {
  final docUser =
      FirebaseFirestore.instance.collection('Class Code').doc(classCode);

  final json = {'classCode': classCode, 'course': course};

  await docUser.set(json);
}
