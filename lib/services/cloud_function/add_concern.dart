import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

Future addConcern(
  String name,
  String course,
  String yearLevel,
  String email,
) async {
  final docUser = FirebaseFirestore.instance
      .collection('Concerns')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final box = GetStorage();

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'name': name,
    'email': email,
    'course': course,
    'yearLevel': yearLevel,
    'id': docUser.id,
    'concern': box.read('concern'),
    'dateTime': DateTime.now(),
    'time': tdata,
  };

  await docUser.set(json);
}
