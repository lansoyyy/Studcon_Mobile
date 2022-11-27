import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyAccent,
      appBar: AppbarWidget('John Doe'),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return Container(
                    height: 100,
                    width: 150,
                    decoration: const BoxDecoration(color: Colors.white),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
