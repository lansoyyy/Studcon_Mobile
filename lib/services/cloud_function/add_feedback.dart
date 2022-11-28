import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future addFeedback(
  String feedback,
  String name,
  String course,
  String yearLevel,
  String email,
) async {
  final docUser = FirebaseFirestore.instance.collection('Feedbacks').doc();

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'name': name,
    'email': email,
    'course': course,
    'yearLevel': yearLevel,
    'id': docUser.id,
    'feedback': feedback,
    'dateTime': DateTime.now(),
    'time': tdata,
  };

  await docUser.set(json);
}
