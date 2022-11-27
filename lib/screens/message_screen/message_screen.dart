import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: TextRegular(
                                text: '8:45pm',
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                          const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            style: TextStyle(
                              fontFamily: 'QRegular',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          ListTile(
                            title: TextBold(
                                text: 'John Doe',
                                fontSize: 14,
                                color: Colors.black),
                            subtitle: TextRegular(
                                text: 'IT Department',
                                fontSize: 10,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
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
