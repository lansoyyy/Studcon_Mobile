import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/screens/message_screen/message_screen.dart';
import 'package:consultation_system_mobile/services/cloud_function/add_code.dart';
import 'package:consultation_system_mobile/services/cloud_function/add_concern.dart';
import 'package:consultation_system_mobile/services/cloud_function/add_section.dart';
import 'package:consultation_system_mobile/services/providers.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/button_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

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

    late String section = '';
    late String classCode = '';

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
              itemBuilder: (context, index99) {
                return Consumer(
                  builder: ((context, ref, child) {
                    return ListTile(
                      onTap: () async {
                        if (data.docs[index99]['status'] == 'Inactive') {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: const Text(
                                      'Inactive Status',
                                      style: TextStyle(fontFamily: 'QRegular'),
                                    ),
                                    actions: <Widget>[
                                      MaterialButton(
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
                          if (int.parse(tdata) <= data.docs[index99]['from'] &&
                              int.parse(tdata) >= data.docs[index99]['to']) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: const Text(
                                        'This person is not available in this period of time',
                                        style:
                                            TextStyle(fontFamily: 'QRegular'),
                                      ),
                                      actions: <Widget>[
                                        MaterialButton(
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
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      height: 300,
                                      child: SingleChildScrollView(
                                        child: ExpansionTile(
                                          children: [
                                            StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
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
                                                  if (snapshot
                                                          .connectionState ==
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
                                                  return SizedBox(
                                                    height: 280,
                                                    child: ListView.builder(
                                                        itemCount: snapshot
                                                                .data?.size ??
                                                            0,
                                                        itemBuilder: (context,
                                                            index1111) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20,
                                                                    right: 20),
                                                            child:
                                                                MaterialButton(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              7.5),
                                                                    ),
                                                                    color: Colors
                                                                            .blueAccent[
                                                                        700],
                                                                    minWidth:
                                                                        200,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        TextRegular(
                                                                            text: data12.docs[index1111][
                                                                                'name'],
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.white),
                                                                        const Icon(
                                                                          Icons
                                                                              .double_arrow_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context);
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Dialog(
                                                                              child: SizedBox(
                                                                                height: 300,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                                                                      child: SizedBox(
                                                                                        height: 50,
                                                                                        child: TextFormField(
                                                                                          style: const TextStyle(color: Colors.black, fontFamily: 'QRegular'),
                                                                                          onChanged: (_input) {
                                                                                            section = _input;
                                                                                          },
                                                                                          decoration: InputDecoration(
                                                                                            labelText: 'Section',
                                                                                            fillColor: Colors.white,
                                                                                            filled: true,
                                                                                            enabledBorder: OutlineInputBorder(
                                                                                              borderSide: const BorderSide(width: 1, color: Colors.grey),
                                                                                              borderRadius: BorderRadius.circular(5),
                                                                                            ),
                                                                                            focusedBorder: OutlineInputBorder(
                                                                                              borderSide: const BorderSide(width: 1, color: primary),
                                                                                              borderRadius: BorderRadius.circular(5),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                                                                      child: SizedBox(
                                                                                        height: 50,
                                                                                        child: TextFormField(
                                                                                          style: const TextStyle(color: Colors.black, fontFamily: 'QRegular'),
                                                                                          onChanged: (_input) {
                                                                                            classCode = _input;
                                                                                          },
                                                                                          decoration: InputDecoration(
                                                                                            labelText: 'Class Code',
                                                                                            fillColor: Colors.white,
                                                                                            filled: true,
                                                                                            enabledBorder: OutlineInputBorder(
                                                                                              borderSide: const BorderSide(width: 1, color: Colors.grey),
                                                                                              borderRadius: BorderRadius.circular(5),
                                                                                            ),
                                                                                            focusedBorder: OutlineInputBorder(
                                                                                              borderSide: const BorderSide(width: 1, color: primary),
                                                                                              borderRadius: BorderRadius.circular(5),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                                                                      child: ButtonWidget(
                                                                                        text: 'Continue',
                                                                                        onPressed: () async {
                                                                                          if (section == '' || classCode == '') {
                                                                                            Fluttertoast.showToast(msg: 'Please input your section and class code!');
                                                                                          } else {
                                                                                            var collection = FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);
                                                                                            var querySnapshot = await collection.get();

                                                                                            for (var queryDocumentSnapshot in querySnapshot.docs) {
                                                                                              Map<String, dynamic> data = queryDocumentSnapshot.data();

                                                                                              addConcern(data['name'], data['course'], data['yearLevel'], data['email'], data['profilePicture'], data12.docs[index1111]['name'], classCode, section);
                                                                                              addSection(section);
                                                                                              addCode(classCode);
                                                                                            }
                                                                                            Navigator.of(context).pop();
                                                                                            box.write('concern', data12.docs[index1111]['name']);
                                                                                            ref.read(instructorIdProvider.notifier).state = data.docs[index99].id;
                                                                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MessageScreen()));
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          });
                                                                    }),
                                                          );
                                                        }),
                                                  );
                                                }),
                                          ],
                                          title: TextRegular(
                                              text: 'CONCERN',
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        }
                      },
                      title: TextRegular(
                          text: data.docs[index99]['first_name'] +
                              ' ' +
                              data.docs[index99]['sur_name'],
                          fontSize: 12,
                          color: Colors.black),
                      subtitle: TextRegular(
                          text: data.docs[index99]['department'],
                          fontSize: 10,
                          color: Colors.grey),
                      trailing: const Icon(Icons.arrow_right),
                      tileColor: Colors.white,
                      leading: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          minRadius: 25,
                          maxRadius: 25,
                          backgroundColor: primary,
                          child: TextBold(
                              text: data.docs[index99]['first_name'][0],
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    );
                  }),
                );
              });
        });
  }
}
