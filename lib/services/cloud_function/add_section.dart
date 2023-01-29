import 'package:cloud_firestore/cloud_firestore.dart';

Future addSection(String section, String course) async {
  final docUser = FirebaseFirestore.instance.collection('Section').doc(section);

  final json = {'section': section, 'course': course};

  await docUser.set(json);
}
