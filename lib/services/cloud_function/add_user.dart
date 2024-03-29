import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/services/cloud_function/add_code.dart';
import 'package:consultation_system_mobile/services/cloud_function/add_section.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(String name, String contactNumber, String address, String course,
    String yearLevel, String email, String classCode, String section) async {
  final docUser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'email': email,
    'contactNumber': contactNumber,
    'address': address,
    'course': course,
    'yearLevel': yearLevel,
    'id': docUser.id,
    'profilePicture': 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    'status': 'Active',
    'notif': [],
    'classCode': classCode,
    'section': section,
  };

  FirebaseFirestore.instance.collection('Enrolled').doc(course).update({
    'enrolled': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
  });

  addCode(classCode, course);
  addSection(section, course);

  await docUser.set(json);
}
