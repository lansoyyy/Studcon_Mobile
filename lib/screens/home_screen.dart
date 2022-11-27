import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:consultation_system_mobile/widgets/drawer_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyAccent,
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Messages'),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Container(
                  child: ListTile(
                    leading: const Icon(Icons.search, color: Colors.black),
                    title: TextRegular(
                        text: 'Search instructor',
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: greyAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: ListTile(
                      subtitle: TextRegular(
                          text: '8:4pm', fontSize: 10, color: Colors.grey),
                      title: TextRegular(
                          text: 'Lorem Ipsum',
                          fontSize: 12,
                          color: Colors.black),
                      trailing: const Icon(Icons.arrow_right),
                      tileColor: Colors.white,
                      leading: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          minRadius: 25,
                          maxRadius: 25,
                          backgroundColor: greyAccent,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
