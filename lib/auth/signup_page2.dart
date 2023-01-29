import 'package:consultation_system_mobile/services/cloud_function/add_user.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/button_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_page.dart.dart';

class SignupPage2 extends StatefulWidget {
  late String name;

  late String contactNumber;

  late String address;

  late String email;

  late String password;
  late String classCode;
  late String section;

  String productCategory;
  String course;

  SignupPage2(
      {required this.name,
      required this.contactNumber,
      required this.address,
      required this.email,
      required this.password,
      required this.productCategory,
      required this.section,
      required this.classCode,
      required this.course});

  @override
  State<SignupPage2> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage2> {
  var _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 75,
              ),
              Center(
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green[700]!,
                        width: 7.5,
                      ),
                    ),
                    child: Center(
                      child: TextBold(
                          text: '2 of 2', fontSize: 18, color: primary),
                    )),
              ),
              const SizedBox(height: 10),
              TextBold(
                  text: 'Account Registration',
                  fontSize: 18,
                  color: Colors.black),
              const SizedBox(height: 5),
              TextRegular(
                  text: 'Provide basic account credentials',
                  fontSize: 12,
                  color: Colors.black),
              const SizedBox(height: 20),
              TextRegular(
                  text:
                      '----------------- BUKIDNON STATE UNIVERSITY -----------------',
                  fontSize: 12,
                  color: Colors.black),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: TextRegular(
                      text:
                          'By clicking register, I hereby consent to the collection, use, storage, processing and retention by Bukidnon State University of all personal and academic information I may have provided herein, including all documents that I may hereafter execute or submit in connection with my transaction in the University. I hereby agree that the above-mentioned personal information will be accessed and used by the Admissions personnel and by other university personnel who are involved in the consultation. I understand that in relation to the benefits granted under RA 10931 or the Universal Access to Quality Tertiary Education Act, personal information collected and processed in connection to BukSU consultation process shall be shared to concerned government agencies. ',
                      fontSize: 12,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.only(right: 20),
                    width: 50,
                    child: SwitchListTile(
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Visibility(
                visible: _value,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: ButtonWidget(
                          onPressed: () async {
                            print(widget.email);
                            if (widget.email.contains('student.buksu.edu.ph')) {
                              try {
                                var user = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: widget.email,
                                        password: widget.password);

                                user.user!.sendEmailVerification();

                                addUser(
                                    widget.name,
                                    widget.contactNumber,
                                    widget.address,
                                    widget.course,
                                    widget.productCategory,
                                    widget.email,
                                    widget.classCode,
                                    widget.section);
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: SizedBox(
                                            height: 300,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .check_circle_outline_outlined,
                                                  size: 75,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                TextBold(
                                                    text:
                                                        'Registered Succesfully!',
                                                    fontSize: 18,
                                                    color: Colors.black),
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                                ButtonWidget(
                                                    onPressed: () async {
                                                      Fluttertoast.showToast(
                                                          toastLength:
                                                              Toast.LENGTH_LONG,
                                                          msg:
                                                              'Verification was sent to ${widget.email}');

                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const LoginPage()));
                                                    },
                                                    text: 'Continue'),
                                              ],
                                            )),
                                      );
                                    });
                              } catch (e) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => AlertDialog(
                                          content: Text(
                                            e.toString(),
                                            style: const TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                        content: const Text(
                                          'Invalid Email\nOnly institutional email is accepted',
                                          style:
                                              TextStyle(fontFamily: 'QRegular'),
                                        ),
                                        actions: <Widget>[
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Close',
                                              style: TextStyle(
                                                  fontFamily: 'QRegular',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ));
                            }
                          },
                          text: 'SUBMIT'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
