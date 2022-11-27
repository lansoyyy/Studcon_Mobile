import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({Key? key}) : super(key: key);

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyAccent,
      appBar: AppbarWidget('John Doe'),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    height: 100,
                    width: 50,
                    decoration: const BoxDecoration(color: Colors.white),
                  );
                }),
              ),
            ),
          ),
          Container(
            child: ListTile(
              leading: SizedBox(
                width: 300,
                child: Center(
                  child: TextFormField(
                    controller: messageController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          messageController.clear();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                      ),
                      hintText: 'Type a message',
                      hintStyle: const TextStyle(
                          fontFamily: 'QRegular',
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            width: double.infinity,
            height: 75,
            color: primary,
          ),
        ],
      ),
    );
  }
}
