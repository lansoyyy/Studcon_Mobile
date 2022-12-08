import 'package:consultation_system_mobile/services/cloud_function/add_user.dart';
import 'package:consultation_system_mobile/widgets/button_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/signup.gif',
              height: 180,
            ),
            const SizedBox(height: 20),
            TextBold(
                text: 'Personal Information',
                fontSize: 18,
                color: Colors.black),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  name = _input;
                },
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
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
                  suffixIcon: const Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
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
                  suffixIcon: const Icon(
                    Icons.location_history_outlined,
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
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
                  color: Colors.grey[200],
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
                        value: 1,
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
                        value: 2,
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
                        value: 3,
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
                        value: 4,
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
                        value: 5,
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
                  color: Colors.grey[200],
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
            const SizedBox(height: 20),
            TextBold(
                text: 'Login Credentials', fontSize: 18, color: Colors.black),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  email = _input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
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
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                obscureText: true,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  password = _input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
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
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email, password: password);
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline_outlined,
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
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
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
                                style: const TextStyle(fontFamily: 'QRegular'),
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
                text: 'Register'),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
