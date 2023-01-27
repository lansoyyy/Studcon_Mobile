import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/services/cloud_function/add_message.dart';
import 'package:consultation_system_mobile/services/providers.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

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
  late int to = 0;
  late int from = 0;

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
          to = data['to'];
          from = data['from'];
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
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent[700],
              minRadius: 17.5,
              maxRadius: 17.5,
              child: TextBold(text: name[0], fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextRegular(text: name, fontSize: 18, color: Colors.white),
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Concerns')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading'));
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      dynamic data = snapshot.data;
                      return TextBold(
                          text: data['type'] ?? '',
                          fontSize: 10,
                          color: Colors.white);
                    })
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(ref.read(instructorIdProvider.notifier).state)
                  .doc(FirebaseAuth.instance.currentUser!.uid)
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
                        return data.docs[index]['name'] == myName
                            ? Column(
                                children: [
                                  SizedBox(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SingleChildScrollView(
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    child: Text(
                                                      data.docs[index]
                                                          ['message'],
                                                      style: const TextStyle(
                                                        fontFamily: 'QRegular',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            margin: const EdgeInsets.fromLTRB(
                                                50, 5, 20, 5),
                                            width: 180,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 40, left: 150),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextRegular(
                                            text: data.docs[index]['time'],
                                            fontSize: 12,
                                            color: Colors.grey),
                                        TextRegular(
                                            text: 'You',
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: primary,
                                          minRadius: 20,
                                          maxRadius: 20,
                                          child: TextBold(
                                              text: data.docs[index]['name'][0],
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        SingleChildScrollView(
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    child: Text(
                                                      data.docs[index]
                                                          ['message'],
                                                      style: const TextStyle(
                                                        fontFamily: 'QRegular',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            margin: const EdgeInsets.fromLTRB(
                                                20, 5, 50, 5),
                                            width: 180,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 120, left: 80),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextRegular(
                                            text: data.docs[index]['name'],
                                            fontSize: 12,
                                            color: Colors.grey),
                                        TextRegular(
                                            text: data.docs[index]['time'],
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                      }),
                    ),
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: ListTile(
                leading: SizedBox(
                  width: 300,
                  child: Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 90),
                        child: TextFormField(
                          style: const TextStyle(
                            fontFamily: 'QRegular',
                            color: Colors.black,
                          ),
                          controller: messageController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'Write a message...',
                            hintStyle: TextStyle(
                                fontFamily: 'QRegular',
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextRegular(
                          text: 'Send', fontSize: 14, color: Colors.white),
                      color: Colors.blueAccent[700],
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('CONSULTATION-USERS')
                            .doc(ref.watch(instructorIdProvider.notifier).state)
                            .update({
                          'notif': FieldValue.arrayUnion([myName]),
                        });

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
                            to,
                            from);

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

                        messageController.clear();
                      }),
                ),
              ),
              width: double.infinity,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
