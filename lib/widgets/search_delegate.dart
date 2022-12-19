import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/screens/message_screen/message_screen.dart';
import 'package:consultation_system_mobile/services/providers.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

import '../services/cloud_function/add_concern.dart';

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

    String tdata = DateFormat("hh").format(DateTime.now());

    print(tdata);

    late String myName;
    late String myEmail;
    late String myCourse;
    late String myYear;
    late String myProfile;

    // TODO: implement buildSuggestions
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('CONSULTATION-USERS')
            .where('first_name',
                isGreaterThanOrEqualTo: toBeginningOfSentenceCase(query))
            .where('first_name',
                isLessThan: '${toBeginningOfSentenceCase(query)}z')
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
                      onTap: () async {
                        if (data.docs[index]['status'] == 'Inactive') {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: const Text(
                                      'Inactive Status',
                                      style: TextStyle(fontFamily: 'QRegular'),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(
                                              fontFamily: 'QRegular',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ));
                        } else {
                          if (int.parse(tdata) <= data.docs[index]['from'] &&
                              int.parse(tdata) >= data.docs[index]['to']) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: const Text(
                                        'This person is not available in this period of time',
                                        style:
                                            TextStyle(fontFamily: 'QRegular'),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text(
                                            'Close',
                                            style: TextStyle(
                                                fontFamily: 'QRegular',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      color: Colors.grey[200],
                                      height: 275,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextBold(
                                              text: 'Type of concern',
                                              fontSize: 14,
                                              color: Colors.black),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('Categ')
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasError) {
                                                  print('error');
                                                  return const Center(
                                                      child: Text('Error'));
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  print('waiting');
                                                  return const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 50),
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                      color: Colors.black,
                                                    )),
                                                  );
                                                }

                                                final data12 =
                                                    snapshot.requireData;
                                                return Expanded(
                                                  child: SizedBox(
                                                    child: ListView.builder(
                                                        itemCount: snapshot
                                                                .data?.size ??
                                                            0,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20,
                                                                    right: 20),
                                                            child:
                                                                MaterialButton(
                                                                    color: Colors
                                                                        .white,
                                                                    minWidth:
                                                                        200,
                                                                    child: TextRegular(
                                                                        text: data12.docs[index]
                                                                            [
                                                                            'name'],
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                    onPressed:
                                                                        () async {
                                                                      var collection = FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Users')
                                                                          .where(
                                                                              'id',
                                                                              isEqualTo: FirebaseAuth.instance.currentUser!.uid);
                                                                      var querySnapshot =
                                                                          await collection
                                                                              .get();

                                                                      for (var queryDocumentSnapshot
                                                                          in querySnapshot
                                                                              .docs) {
                                                                        Map<String,
                                                                                dynamic>
                                                                            data =
                                                                            queryDocumentSnapshot.data();

                                                                        addConcern(
                                                                            data['name'],
                                                                            data['course'],
                                                                            data['yearLevel'],
                                                                            data['email'],
                                                                            data['profilePicture'],
                                                                            data12.docs[index]['name']);
                                                                      }
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      box.write(
                                                                          'concern',
                                                                          'Requirements');
                                                                      ref.read(instructorIdProvider.notifier).state = data
                                                                          .docs[
                                                                              index]
                                                                          .id;
                                                                      Navigator.of(
                                                                              context)
                                                                          .pushReplacement(
                                                                              MaterialPageRoute(builder: (context) => MessageScreen()));
                                                                    }),
                                                          );
                                                        }),
                                                  ),
                                                );
                                              }),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        }
                      },
                      title: TextRegular(
                          text: data.docs[index]['first_name'] +
                              ' ' +
                              data.docs[index]['sur_name'],
                          fontSize: 12,
                          color: Colors.black),
                      subtitle: TextRegular(
                          text: data.docs[index]['department'],
                          fontSize: 10,
                          color: Colors.grey),
                      trailing: const Icon(Icons.arrow_right),
                      tileColor: Colors.white,
                      leading: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          minRadius: 25,
                          maxRadius: 25,
                          backgroundColor: greyAccent,
                          backgroundImage:
                              NetworkImage(data.docs[index]['profilePicture']),
                        ),
                      ),
                    );
                  }),
                );
              });
        });
  }
}
