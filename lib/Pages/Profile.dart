import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meet_ups/Pages/Subcategory.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class Category extends StatefulWidget {
  final String gender, age;
  final List intrests;
  const Category({Key key, this.gender, this.age, this.intrests})
      : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  TextEditingController aboutcontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  PickedFile image;

  void gallery() async {
    final _userimage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      image = _userimage;
    });
  }

  void camera() async {
    final _userimage = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      image = _userimage;
    });
  }

  uploadimage() async {
    String fileName = basename(image.path); //Get File Name - Or set one
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    TaskSnapshot uploadTask =
        await firebaseStorageRef.putFile(File(image.path));
    String url = await uploadTask.ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      "Hello " +
                          Meetup.sharedPreferences.getString('username'),
                      style: GoogleFonts.josefinSans(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 3,
                      width: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                        Colors.purple,
                        Colors.pinkAccent
                      ])),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Create a profile picture',
                  style: GoogleFonts.josefinSans(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey,
              backgroundImage: image == null
                  ? NetworkImage(
                      'https://media.tarkett-image.com/large/TH_26500003_001.jpg')
                  : FileImage(File(image.path)),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Text('Choose a profile picture',
                                  style: GoogleFonts.josefinSans(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              child: Row(children: [
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {
                                      gallery();
                                    },
                                    icon: Icon(
                                      EvaIcons.image,
                                      size: 15,
                                      color: Colors.purple,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'From gallery',
                                  style: GoogleFonts.josefinSans(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                IconButton(
                                    onPressed: () {
                                      camera();
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.camera,
                                      color: Colors.purple,
                                      size: 15,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Take a photo',
                                  style: GoogleFonts.josefinSans(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  EvaIcons.camera,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'About',
                    style: GoogleFonts.josefinSans(
                      color: Colors.grey,
                      letterSpacing: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              // height: 2,
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: TextField(
                  style: GoogleFonts.josefinSans(color: Colors.black),
                  controller: aboutcontroller,
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    hintText: ' ',
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Location',
                    style: GoogleFonts.josefinSans(
                      color: Colors.grey,
                      letterSpacing: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              // height: 2,
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 130.0, right: 130),
                child: TextField(
                  style: GoogleFonts.josefinSans(color: Colors.black),
                  controller: locationcontroller,
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    hintText: ' ',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 250,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  aboutcontroller.text.isEmpty &&
                          locationcontroller.text.isEmpty
                      ? Toast.show(
                          'Please fill the respective items',
                          context,
                          backgroundColor: Colors.purple,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                        )
                      : uploadimage().then((url) {
                          FirebaseFirestore.instance
                              .collection('Category')
                              .doc(Meetup.sharedPreferences.getString("uid"))
                              .set({
                            'location': locationcontroller.text,
                            'about': aboutcontroller.text,
                            'username': Meetup.sharedPreferences
                                .getString("username"),
                            'imageurl': url,
                            'age': widget.age,
                            'intrest': widget.intrests,
                            'gender': widget.gender,
                            'email':Meetup.sharedPreferences.getString("email"),
                            'uid':Meetup.sharedPreferences.getString('uid')
                          }).whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: SubCategory(
                                      intrest: widget.intrests,
                                    ),
                                    type: PageTransitionType.rightToLeft));
                          });
                        });
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[Colors.purple, Colors.pinkAccent]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Next',
                        style: GoogleFonts.josefinSans(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
