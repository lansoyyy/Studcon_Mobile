import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:consultation_system_mobile/widgets/drawer_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyAccent,
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Consultation History'),
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: ListTile(
            subtitle:
                TextRegular(text: '8:4pm', fontSize: 10, color: Colors.grey),
            title: TextRegular(
                text: 'Lorem Ipsum', fontSize: 12, color: Colors.black),
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
    );
  }
}
