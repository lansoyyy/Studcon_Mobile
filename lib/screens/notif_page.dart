import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/screens/message_screen/message_screen.dart';
import 'package:consultation_system_mobile/services/providers.dart';
import 'package:consultation_system_mobile/widgets/appbar_widget.dart';
import 'package:consultation_system_mobile/widgets/drawer_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotifPage extends ConsumerWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Notifications'),
      body: StreamBuilder<DocumentSnapshot>(
          stream: userData,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading'));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            dynamic data = snapshot.data;

            List notifs = data['notif'];
            return ListView.builder(
                itemCount: notifs.reversed.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Card(
                      child: ListTile(
                        onTap: () async {
                          ref.read(instructorIdProvider.notifier).state =
                              notifs[index]['id'];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MessageScreen()));
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'notif': FieldValue.arrayRemove([notifs[index]]),
                          });
                        },
                        subtitle: TextRegular(
                            text: notifs[index]['name'],
                            fontSize: 12,
                            color: Colors.grey),
                        trailing: TextRegular(
                            text: notifs[index]['time'],
                            fontSize: 12,
                            color: Colors.black),
                        title: Text(
                          notifs[index]['message'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'QRegular'),
                        ),
                        tileColor: Colors.white,
                      ),
                    ),
                  );
                }));
          }),
    );
  }
}
