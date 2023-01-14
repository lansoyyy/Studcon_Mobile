import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/auth/login_page.dart.dart';
import 'package:consultation_system_mobile/screens/home_screen.dart';
import 'package:consultation_system_mobile/screens/profile_page.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<DrawerWidget> {
  var hasLoaded = false;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('CoverPhoto/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('CoverPhoto/$fileName')
            .getDownloadURL();

        setState(() {
          hasLoaded = true;
        });

        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'profilePicture': imageURL,
        });

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return SizedBox(
      width: 220,
      child: Drawer(
        backgroundColor: primary,
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: <Widget>[
            StreamBuilder<DocumentSnapshot>(
                stream: userData,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text('Loading'));
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  dynamic data = snapshot.data;
                  return UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: primary,
                    ),
                    accountEmail: TextRegular(
                        text: data['email'], fontSize: 10, color: Colors.white),
                    accountName: TextBold(
                      text: data['name'],
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    currentAccountPicture: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: ((context) {
                                return SizedBox(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: (() {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: ((context) {
                                                return Dialog(
                                                  child: SizedBox(
                                                    height: 300,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    data[
                                                                        'profilePicture']))),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }));
                                        }),
                                        leading: Icon(Icons.person),
                                        trailing: Icon(
                                            Icons.arrow_forward_ios_rounded),
                                        title: TextRegular(
                                            text: 'View Profile',
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                      ListTile(
                                        onTap: (() {
                                          uploadPicture('gallery');
                                        }),
                                        leading: Icon(Icons.upload),
                                        trailing: Icon(
                                            Icons.arrow_forward_ios_rounded),
                                        title: TextRegular(
                                            text: 'Upload Photo',
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              }));
                        },
                        child: CircleAvatar(
                          minRadius: 50,
                          maxRadius: 50,
                          backgroundImage: NetworkImage(data['profilePicture']),
                        ),
                      ),
                    ),
                  );
                }),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.message,
                color: Colors.white,
              ),
              title: TextBold(
                text: 'Messages',
                fontSize: 12,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: TextBold(
                text: 'Personal Information',
                fontSize: 12,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: TextBold(
                text: 'Log out',
                fontSize: 12,
                color: Colors.white,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            'Logout Confirmation',
                            style: TextStyle(
                                fontFamily: 'QBold',
                                fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                            'Are you sure you want to Logout?',
                            style: TextStyle(fontFamily: 'QRegular'),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
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
            ),
          ],
        ),
      ),
    );
  }
}
