import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/drawer_widget.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name = '';
  late String email = '';
  late String contactNumber = '';
  late String address = '';
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
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: primary,
        backgroundColor: Colors.transparent,
        title: TextRegular(
            text: 'Personal Information', fontSize: 18, color: primary),
      ),
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
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CircleAvatar(
                        minRadius: 50,
                        maxRadius: 50,
                        backgroundImage: NetworkImage(data['profilePicture']),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: MaterialButton(
                          height: 30,
                          child: TextRegular(
                              text: 'Upload Photo',
                              fontSize: 12,
                              color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minWidth: 150,
                          color: Colors.blueAccent[400],
                          onPressed: () {
                            uploadPicture('gallery');
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextRegular(
                              text: 'EDIT YOUR PROFILE',
                              fontSize: 14,
                              color: Colors.black),
                          const SizedBox(
                            height: 10,
                          ),
                          TextRegular(
                              text: 'Full name',
                              fontSize: 12,
                              color: Colors.black),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            width: 300,
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'QRegular'),
                              onChanged: (_input) {
                                name = _input;
                              },
                              decoration: InputDecoration(
                                labelText: data['name'],
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: primary),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextRegular(
                              text: 'Email', fontSize: 12, color: Colors.black),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            width: 300,
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'QRegular'),
                              onChanged: (_input) {
                                email = _input;
                              },
                              decoration: InputDecoration(
                                labelText: data['email'],
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: primary),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextRegular(
                              text: 'Contact Number',
                              fontSize: 12,
                              color: Colors.black),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            width: 300,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'QRegular'),
                              onChanged: (_input) {
                                contactNumber = _input;
                              },
                              decoration: InputDecoration(
                                labelText: data['contactNumber'],
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: primary),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextRegular(
                              text: 'Address',
                              fontSize: 12,
                              color: Colors.black),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            width: 300,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'QRegular'),
                              onChanged: (_input) {
                                address = _input;
                              },
                              decoration: InputDecoration(
                                labelText: data['address'],
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: primary),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: MaterialButton(
                                  height: 40,
                                  child: TextBold(
                                      text: 'UPDATE',
                                      fontSize: 16,
                                      color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  minWidth: 150,
                                  color: Colors.blueAccent[700],
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      'name': name == '' ? data['name'] : name,
                                      'email':
                                          email == '' ? data['email'] : email,
                                      'contactNumber': contactNumber == ''
                                          ? data['contactNumber']
                                          : contactNumber,
                                      'address': address == ''
                                          ? data['address']
                                          : address,
                                    });
                                    Fluttertoast.showToast(
                                        msg: 'Updated Succesfully!');
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
