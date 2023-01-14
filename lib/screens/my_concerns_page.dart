import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:consultation_system_mobile/widgets/drawer_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyConcernPage extends StatelessWidget {
  const MyConcernPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: greyAccent,
        appBar: AppbarWidget('My Concerns'),
        drawer: const DrawerWidget(),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Concerns')
                .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: TextBold(
                            text: data.docs[index]['concern'],
                            fontSize: 18,
                            color: Colors.black),
                        subtitle: TextBold(
                            text: 'Status: ${data.docs[index]['type']}',
                            fontSize: 12,
                            color: Colors.green),
                        trailing: data.docs[index]['type'] == 'Unsolved'
                            ? IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: const Text(
                                              'Are you sure you want to label this ticket as Solved?',
                                              style: TextStyle(
                                                  fontFamily: 'QRegular'),
                                            ),
                                            actions: <Widget>[
                                              MaterialButton(
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
                                              MaterialButton(
                                                onPressed: () async {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                  FirebaseFirestore.instance
                                                      .collection('Concerns')
                                                      .doc(data.docs[index].id)
                                                      .update({
                                                    'type': 'Solved',
                                                  });
                                                },
                                                child: const Text(
                                                  'Continue',
                                                  style: TextStyle(
                                                      fontFamily: 'QRegular',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ));
                                },
                                icon: const Icon(Icons.check_circle_outline),
                              )
                            : const SizedBox(),
                        tileColor: Colors.white,
                      ),
                    );
                  }));
            }));
  }
}
