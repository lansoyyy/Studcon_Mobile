import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/screens/notif_page.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget AppbarWidget(
  String title,
) {
  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  return AppBar(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: primary,
    actions: [
      StreamBuilder<DocumentSnapshot>(
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
            return Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: Badge(
                badgeContent: TextRegular(
                    text: notifs.length.toString(),
                    fontSize: 12,
                    color: Colors.white),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const NotifPage()));
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    )),
              ),
            );
          })
    ],
    title: TextRegular(text: title, fontSize: 18, color: Colors.white),
    centerTitle: true,
  );
}
