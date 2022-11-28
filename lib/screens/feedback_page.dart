import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:consultation_system_mobile/widgets/button_widget.dart';
import 'package:consultation_system_mobile/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({Key? key}) : super(key: key);

  final feedbackController = TextEditingController();

  showToast() {
    Fluttertoast.showToast(
        msg: "Feedback Added Succesfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyAccent,
      appBar: AppbarWidget('Feedback'),
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                maxLines: 8,
                controller: feedbackController,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: primary),
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
              height: 50,
            ),
            ButtonWidget(
                onPressed: () {
                  showToast();
                  feedbackController.clear();
                },
                text: 'Submit Feedback'),
          ],
        ),
      ),
    );
  }
}
