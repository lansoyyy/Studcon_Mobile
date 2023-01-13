import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

Future addConcern(
    String name,
    String course,
    String yearLevel,
    String email,
    String profilePicture,
    String concern,
    String classCode,
    String section) async {
  final docUser = FirebaseFirestore.instance
      .collection('Concerns')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final box = GetStorage();

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'profilePicture': profilePicture,
    'name': name,
    'email': email,
    'course': course,
    'yearLevel': yearLevel,
    'id': docUser.id,
    'concern': concern,
    'dateTime': DateTime.now(),
    'time': tdata,
    'type': 'Unsolved',
    'classCode': classCode,
    'section': section
  };

  await docUser.set(json);
}
