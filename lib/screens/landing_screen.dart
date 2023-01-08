import 'package:consultation_system_mobile/auth/login_page.dart.dart';
import 'package:consultation_system_mobile/auth/signup_page.dart.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/bsu.png',
                height: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              TextBold(
                  text: 'BukSU Consultation',
                  fontSize: 18,
                  color: Colors.white),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                  text: 'Educate. Innovate. Lead',
                  fontSize: 12,
                  color: Colors.white),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: 250,
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupPage()));
                },
                child: TextBold(
                    text: 'REGISTER',
                    fontSize: 18,
                    color: const Color(0xff001C38)),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: MaterialButton(
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: 250,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    },
                    child: TextBold(
                        text: 'LOGIN', fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
        color: const Color(0xff001C38),
      ),
    );
  }
}
