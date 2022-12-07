import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/services/cloud_function/add_message.dart';
import 'package:consultation_system_mobile/services/providers.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/cloud_function/add_concern.dart';

class MessageScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<MessageScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<MessageScreen> {
  final messageController = TextEditingController();

  late String name = '';
  late String email = '';

  @override
  void initState() {
    super.initState();
    getData();
    getData1();
  }

  late String instructorProfile = '';

  getData() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('CONSULTATION-USERS')
        .where('id', isEqualTo: ref.read(instructorIdProvider.notifier).state);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          name = data['first_name'] + ' ' + data['sur_name'];
          email = data['email'];
          instructorProfile = data['profilePicture'];
        }
      });
    }
  }

  late String myName;
  late String myEmail;
  late String myCourse;
  late String myYear;
  late String myProfile;

  getData1() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          myName = data['name'];
          myEmail = data['email'];
          myCourse = data['course'];
          myYear = data['yearLevel'];
          myProfile = data['profilePicture'];
        }
      });
    }
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyAccent,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextRegular(text: name, fontSize: 18, color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: const Text(
                          'Are you sure you want to mark this concern as solved?',
                          style: TextStyle(fontFamily: 'QRegular'),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                  fontFamily: 'QRegular',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              FirebaseFirestore.instance
                                  .collection('Concerns')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                'type': 'Solved',
                              });

                              Navigator.of(context).pop(true);
                            },
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                  fontFamily: 'QRegular',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ));
            },
            icon: const Icon(Icons.check_circle_outline),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseAuth.instance.currentUser!.uid)
                  .doc(ref.read(instructorIdProvider.notifier).state)
                  .collection('Messages')
                  .orderBy('dateTime')
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
                return Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount: snapshot.data?.size ?? 0,
                      itemBuilder: ((context, index) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: TextRegular(
                                      text: data.docs[index]['time'],
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Text(
                                    data.docs[index]['message'],
                                    style: const TextStyle(
                                      fontFamily: 'QRegular',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: TextBold(
                                      text: data.docs[index]['name'],
                                      fontSize: 12,
                                      color: Colors.black),
                                  subtitle: TextRegular(
                                      text: data.docs[index]['course'],
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
                );
              }),
          Container(
            child: ListTile(
              leading: SizedBox(
                width: 300,
                child: Center(
                  child: TextFormField(
                    style: const TextStyle(
                      fontFamily: 'QRegular',
                      color: Colors.white,
                    ),
                    controller: messageController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          addMessage(
                              myYear,
                              instructorProfile,
                              name,
                              email,
                              myCourse,
                              messageController.text,
                              myName,
                              myEmail,
                              ref.watch(instructorIdProvider.notifier).state,
                              box.read('to'),
                              box.read('from'));
                          addMessage2(
                              myYear,
                              myProfile,
                              name,
                              email,
                              myCourse,
                              messageController.text,
                              myName,
                              myEmail,
                              ref.watch(instructorIdProvider.notifier).state);
                          addConcern(
                              myName, myCourse, myYear, myEmail, myProfile);

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
