import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/screens/message_screen/message_screen.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:consultation_system_mobile/widgets/drawer_widget.dart';
import 'package:consultation_system_mobile/widgets/search_delegate.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: SearchMessages(),
                );
              },
              child: Container(
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
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(FirebaseAuth.instance.currentUser!.uid)
                    .doc()
                    .collection('Messages')
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MessageScreen()));
                                },
                                subtitle: TextRegular(
                                    text: '8:4pm',
                                    fontSize: 10,
                                    color: Colors.grey),
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
                                    backgroundImage:
                                        AssetImage('assets/images/profile.png'),
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
