import 'package:consultation_system_mobile/auth/signup_page2.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/button_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:flutter/material.dart';

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

  late String classCode = '';
  late String section = '';

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
                      color: Colors.green[200]!,
                      width: 7.5,
                    ),
                  ),
                  child: Center(
                    child:
                        TextBold(text: '1 of 2', fontSize: 18, color: primary),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  section = _input;
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
                  labelText: 'Section',
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
                  classCode = _input;
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
                  labelText: 'Class Code',
                  labelStyle: const TextStyle(
                    fontFamily: 'QRegular',
                    color: Colors.black,
                    fontSize: 12.0,
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupPage2(
                                  classCode: classCode,
                                  section: section,
                                  name: name,
                                  contactNumber: contactNumber,
                                  address: address,
                                  email: email,
                                  password: password,
                                  productCategory: productCategory,
                                  course: course,
                                )));
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
