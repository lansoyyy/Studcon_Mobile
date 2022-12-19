import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/services/cloud_function/add_feedback.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:consultation_system_mobile/widgets/button_widget.dart';
import 'package:consultation_system_mobile/widgets/drawer_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final feedbackController = TextEditingController();

  late String feedback = '';

  late bool hasContent = false;

  late double rating = 5.00;

  late String userRate = 'Excellent';

  showToast() {
    Fluttertoast.showToast(
        msg: "Feedback Added Succesfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: primary,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyAccent,
      appBar: AppbarWidget('Feedback'),
      drawer: const DrawerWidget(),
      body: StreamBuilder<DocumentSnapshot>(
          stream: userData,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading'));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            dynamic data = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextFormField(
                      maxLines: 8,
                      onChanged: (_input) {
                        feedback = _input;

                        if (_input != '') {
                          setState(() {
                            hasContent = true;
                          });
                        } else if (_input == '') {
                          setState(() {
                            feedback = '';
                          });
                        }
                      },
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'QRegular'),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: primary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: 'Your feedback',
                        labelStyle: const TextStyle(
                          fontFamily: 'QRegular',
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: hasContent,
                    child: TextBold(
                        text: 'Rate your experience',
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: hasContent,
                    child: RatingBar.builder(
                      initialRating: 5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (_rating) {
                        setState(() {
                          rating = _rating;

                          if (_rating == 5) {
                            userRate = 'Excellent';
                          } else if (_rating == 4) {
                            userRate = 'Very Good';
                          }
                          if (_rating == 3) {
                            userRate = 'Good';
                          }
                          if (_rating == 2) {
                            userRate = 'Fair';
                          }
                          if (_rating == 1) {
                            userRate = 'Bad';
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: hasContent,
                    child: TextBold(
                        text: userRate, fontSize: 18, color: Colors.amber),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonWidget(
                      onPressed: () {
                        addFeedback(
                            data['profilePicture'],
                            feedback,
                            data['name'],
                            data['course'],
                            data['yearLevel'],
                            data['email'],
                            rating);
                        showToast();
                        setState(() {
                          feedback = '';
                          hasContent = false;
                        });
                      },
                      text: 'Submit Feedback'),
                ],
              ),
            );
          }),
    );
  }
}
