import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/screens/message_screen/message_screen.dart';
import 'package:consultation_system_mobile/services/providers.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:consultation_system_mobile/widgets/drawer_widget.dart';
import 'package:consultation_system_mobile/widgets/search_delegate.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  String tdata = DateFormat("hh").format(DateTime.now());

  final box = GetStorage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Messages'),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: SearchMessages(),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Container(
                  child: ListTile(
                    trailing: const Icon(Icons.search, color: Colors.black),
                    title: TextRegular(
                        text: 'Search bar', fontSize: 12, color: Colors.grey),
                  ),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  print(FirebaseAuth.instance.currentUser!.uid);
                  return Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                          itemCount: snapshot.data?.size ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onTap: () {
                                  if (data.docs[index]['status'] ==
                                      'Inactive') {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              content: const Text(
                                                'Inactive Status',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular'),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: const Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        fontFamily: 'QRegular',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ));
                                  } else {
                                    if (int.parse(tdata) <=
                                            data.docs[index]['from'] &&
                                        int.parse(tdata) >=
                                            data.docs[index]['to']) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                content: const Text(
                                                  'This person is not available in this period of time',
                                                  style: TextStyle(
                                                      fontFamily: 'QRegular'),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: const Text(
                                                      'Close',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'QRegular',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                    } else {
                                      box.write('to', data.docs[index]['to']);
                                      box.write(
                                          'from', data.docs[index]['from']);
                                      ref
                                          .read(instructorIdProvider.notifier)
                                          .state = data.docs[index].id;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MessageScreen()));
                                    }
                                  }
                                },
                                subtitle: TextRegular(
                                    text: data.docs[index]['time'],
                                    fontSize: 10,
                                    color: Colors.grey),
                                title: TextRegular(
                                    text: data.docs[index]['instructorName'],
                                    fontSize: 12,
                                    color: Colors.black),
                                trailing: IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .doc(data.docs[index].id)
                                        .delete();
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                                tileColor: Colors.white,
                                leading: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    minRadius: 25,
                                    maxRadius: 25,
                                    backgroundColor: greyAccent,
                                    backgroundImage: NetworkImage(
                                        data.docs[index]['profilePicture']),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
