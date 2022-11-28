import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/screens/message_screen/message_screen.dart';
import 'package:consultation_system_mobile/services/providers.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

class SearchMessages extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions

    return [
      IconButton(
        onPressed: () {
          if (query != '') {
            close(context, null);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('No Input. Cannot Procceed'),
              ),
            );
          }
        },
        icon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final box = GetStorage();
    // TODO: implement buildSuggestions
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('CONSULTATION-USERS')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('error');
            return const Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('waiting');
            return const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            );
          }

          final data = snapshot.requireData;
          return ListView.builder(
              itemCount: snapshot.data?.size ?? 0,
              itemBuilder: (context, index) {
                return Consumer(
                  builder: ((context, ref, child) {
                    return ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  color: Colors.grey[200],
                                  height: 275,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextBold(
                                          text: 'Type of concern',
                                          fontSize: 14,
                                          color: Colors.black),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MaterialButton(
                                          color: Colors.white,
                                          minWidth: 200,
                                          child: TextRegular(
                                              text: 'Grades',
                                              fontSize: 12,
                                              color: Colors.black),
                                          onPressed: () {
                                            box.write('concern', 'Grades');
                                            ref
                                                .read(instructorIdProvider
                                                    .notifier)
                                                .state = data.docs[index].id;
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessageScreen()));
                                          }),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      MaterialButton(
                                          color: Colors.white,
                                          minWidth: 200,
                                          child: TextRegular(
                                              text: 'Attendance',
                                              fontSize: 12,
                                              color: Colors.black),
                                          onPressed: () {
                                            box.write('concern', 'Attendance');
                                            ref
                                                .read(instructorIdProvider
                                                    .notifier)
                                                .state = data.docs[index].id;
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessageScreen()));
                                          }),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      MaterialButton(
                                          color: Colors.white,
                                          minWidth: 200,
                                          child: TextRegular(
                                              text: 'Requirements',
                                              fontSize: 12,
                                              color: Colors.black),
                                          onPressed: () {
                                            box.write(
                                                'concern', 'Requirements');
                                            ref
                                                .read(instructorIdProvider
                                                    .notifier)
                                                .state = data.docs[index].id;
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessageScreen()));
                                          }),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      MaterialButton(
                                          color: Colors.white,
                                          minWidth: 200,
                                          child: TextRegular(
                                              text: 'Others',
                                              fontSize: 12,
                                              color: Colors.black),
                                          onPressed: () {
                                            box.write('concern', 'Others');
                                            ref
                                                .read(instructorIdProvider
                                                    .notifier)
                                                .state = data.docs[index].id;
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessageScreen()));
                                          }),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      subtitle: TextRegular(
                          text: 'IT Department',
                          fontSize: 10,
                          color: Colors.grey),
                      title: TextRegular(
                          text: data.docs[index]['first_name'] +
                              ' ' +
                              data.docs[index]['sur_name'],
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
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                        ),
                      ),
                    );
                  }),
                );
              });
        });
  }
}
