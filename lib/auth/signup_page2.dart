import 'package:consultation_system_mobile/services/cloud_function/add_user.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/button_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_page.dart.dart';

class SignupPage2 extends StatefulWidget {
  const SignupPage2({Key? key}) : super(key: key);

  @override
  State<SignupPage2> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage2> {
  late String name;

  late String contactNumber;

  late String address;

  late String email;

  late String password;

  var dropDownValue = 1;

  var dropDownValue1 = 1;

  var productCategory = 'First Year';

  var course = 'IT';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
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
                    child:
                        TextBold(text: '2 of 2', fontSize: 18, color: primary),
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
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  email = _input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: primary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    fontFamily: 'QRegular',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: TextRegular(
                  text:
                      'Only institutional email address is allowed. e.g example@student.buksu.edu.ph',
                  fontSize: 12,
                  color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                obscureText: true,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  password = _input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: primary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    fontFamily: 'QRegular',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: TextRegular(
                  text:
                      '- Your password can’t be too similar to your other personal information.\n- Your password must contain at least 8 characters.\n- Your password can’t be a commonly used password.\n- Your password can’t be entirely numeric.',
                  fontSize: 12,
                  color: primary),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  name = _input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: primary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    fontFamily: 'QRegular',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 11,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  contactNumber = _input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: primary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Contact Number',
                  labelStyle: const TextStyle(
                    fontFamily: 'QRegular',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  address = _input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: primary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Address',
                  labelStyle: const TextStyle(
                    fontFamily: 'QRegular',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            TextRegular(text: 'Course', fontSize: 12, color: Colors.black),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: DropdownButton(
                    underline: Container(color: Colors.transparent),
                    iconEnabledColor: Colors.black,
                    isExpanded: true,
                    value: dropDownValue1,
                    items: [
                      DropdownMenuItem(
                        onTap: () {
                          course = "Automotive";
                        },
                        child: Center(
                            child: Row(children: const [
                          Text("Automotive",
                              style: TextStyle(
                                fontFamily: 'QRegular',
                                color: Colors.black,
                              ))
                        ])),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          course = "Food Technology";
                        },
                        child: Center(
                            child: Row(children: const [
                          Text("Food Technology",
                              style: TextStyle(
                                fontFamily: 'QRegular',
                                color: Colors.black,
                              ))
                        ])),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          course = "Electronic Technology";
                        },
                        child: Center(
                            child: Row(children: const [
                          Text("Electronic Technology",
                              style: TextStyle(
                                fontFamily: 'QRegular',
                                color: Colors.black,
                              ))
                        ])),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          course = "Entertainment and\nMultimedia Computing";
                        },
                        child: Center(
                            child: Row(children: const [
                          Text("Entertainment and\nMultimedia Computing",
                              style: TextStyle(
                                fontFamily: 'QRegular',
                                color: Colors.black,
                              ))
                        ])),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          course = "Information Technology";
                        },
                        child: Center(
                            child: Row(children: const [
                          Text("Information Technology",
                              style: TextStyle(
                                fontFamily: 'QRegular',
                                color: Colors.black,
                              ))
                        ])),
                        value: 4,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        dropDownValue1 = int.parse(value.toString());
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextRegular(text: 'Year Level', fontSize: 12, color: Colors.black),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: DropdownButton(
                    underline: Container(color: Colors.transparent),
                    iconEnabledColor: Colors.black,
                    isExpanded: true,
                    value: dropDownValue,
                    items: [
                      DropdownMenuItem(
                        onTap: () {
                          productCategory = "First Year";
                        },
                        child: Center(
                            child: Row(children: const [
                          Text("First Year",
                              style: TextStyle(
                                fontFamily: 'QRegular',
                                color: Colors.black,
                              ))
                        ])),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          productCategory = "Second Year";
                        },
                        child: Center(
                            child: Row(children: const [
                          Text("Second Year",
                              style: TextStyle(
                                fontFamily: 'QRegular',
                                color: Colors.black,
                              ))
                        ])),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          productCategory = "Third Year";
                        },
                        child: Center(
                            child: Row(children: const [
                          Text("Third Year",
                              style: TextStyle(
                                fontFamily: 'QRegular',
                                color: Colors.black,
                              ))
                        ])),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          productCategory = "Fourth Year";
                        },
                        child: Center(
                            child: Row(children: const [
                          Text("Fourth Year",
                              style: TextStyle(
                                fontFamily: 'QRegular',
                                color: Colors.black,
                              ))
                        ])),
                        value: 4,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        dropDownValue = int.parse(value.toString());
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ButtonWidget(
                      onPressed: () async {
                        if (email.contains('student.buksu.edu.ph')) {
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password);

                            var user = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password);

                            user.user!.sendEmailVerification();

                            addUser(name, contactNumber, address, course,
                                productCategory, email);
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
                                                text: 'Registered Succesfully!',
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
                                                          'Verification was to $email');

                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
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
                                        FlatButton(
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
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                    content: const Text(
                                      'Invalid Email\nOnly institutional email is accepted',
                                      style: TextStyle(fontFamily: 'QRegular'),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
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
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
