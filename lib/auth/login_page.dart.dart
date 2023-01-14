import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/auth/signup_page.dart.dart';
import 'package:consultation_system_mobile/screens/forgot_password.dart';
import 'package:consultation_system_mobile/screens/home_screen.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/button_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;

  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  'assets/images/bsu.png',
                  height: 150,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextBold(
                    text: 'Login to BukSU Consultation',
                    fontSize: 18,
                    color: primary),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: TextRegular(text: 'Email', fontSize: 14, color: primary),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: SizedBox(
                  height: 50,
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
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: primary),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child:
                    TextRegular(text: 'Password', fontSize: 14, color: primary),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: SizedBox(
                  height: 50,
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
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: primary),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: ButtonWidget(
                    onPressed: () async {
                      late var status;
                      try {
                        var collection = FirebaseFirestore.instance
                            .collection('Users')
                            .where('email', isEqualTo: email);

                        var querySnapshot = await collection.get();
                        var user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password);

                        setState(() {
                          for (var queryDocumentSnapshot
                              in querySnapshot.docs) {
                            Map<String, dynamic> data =
                                queryDocumentSnapshot.data();
                            status = data['status'];
                          }
                        });

                        if (status == 'Deleted') {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: TextRegular(
                                        text: "Your account has been deleted!",
                                        color: Colors.black,
                                        fontSize: 12),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: TextBold(
                                            text: 'Close',
                                            color: Colors.black,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ));
                          await FirebaseAuth.instance.signOut();
                        } else {
                          if (user.user!.emailVerified == true) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please verify your email!');
                          }
                        }
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: TextRegular(
                                      text: "$e",
                                      color: Colors.black,
                                      fontSize: 12),
                                  actions: <Widget>[
                                    MaterialButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: TextBold(
                                          text: 'Close',
                                          color: Colors.black,
                                          fontSize: 12),
                                    ),
                                  ],
                                ));
                      }
                    },
                    text: 'Login'),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()));
                  },
                  child: TextBold(
                      text: 'Forgot Password?',
                      fontSize: 12,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextRegular(
                      text: "Create an account",
                      fontSize: 14,
                      color: Colors.grey),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignupPage()));
                    },
                    child: TextBold(
                        text: "SIGN UP", fontSize: 16, color: Colors.black),
                  ),
                ],
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
