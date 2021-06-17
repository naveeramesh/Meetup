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
  const Category({Key key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List category = [];
  String gender;
  // String uploadUrl;

  TextEditingController agecontroller = TextEditingController();
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Few steps ago..",
                  style: GoogleFonts.josefinSans(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    letterSpacing: 1,
                  ),
                ),
                Icon(Icons.favorite, size: 20, color: Colors.purple)
              ],
            ),
            SizedBox(
              height: 50,
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
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Choose gender",
                      style: GoogleFonts.josefinSans(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purple[200],
                        child: IconButton(
                          icon: Icon(
                            Icons.female,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            gender = 'Female';
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Female',
                      style: GoogleFonts.josefinSans(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purple[200],
                        child: IconButton(
                          icon: Icon(
                            Icons.male,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            gender = 'Male';
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Male',
                      style: GoogleFonts.josefinSans(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purple[200],
                        child: IconButton(
                          icon: Icon(
                            Icons.transgender,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            gender = 'Transgender';
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Transgender',
                      style: GoogleFonts.josefinSans(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1),
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
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Enter age',
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
            SizedBox(
              height: 20,
            ),
            Container(
              // height: 2,
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 150.0, right: 150),
                child: TextField(
                  style: GoogleFonts.josefinSans(color: Colors.black),
                  controller: agecontroller,
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
                    'Enter your Country',
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
                padding: const EdgeInsets.only(left: 150.0, right: 150),
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
            SizedBox(height: 50),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Select Category',
                  style: GoogleFonts.josefinSans(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ]),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Coding')
                          ? category.remove('Coding')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Coding');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: category.contains('Coding')
                              ? Colors.purple
                              : Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        'Coding',
                        style: GoogleFonts.josefinSans(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Animie')
                          ? category.remove('Animie')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Animie');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: category.contains('Animie')
                            ? Colors.purple
                            : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Animie',
                        style: GoogleFonts.josefinSans(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Film')
                          ? category.remove('Film')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Film');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: category.contains('Film')
                            ? Colors.purple
                            : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Film',
                        style: GoogleFonts.josefinSans(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Naturo')
                          ? category.remove('Naturo')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Naturo');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: category.contains('Naturo')
                            ? Colors.purple
                            : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Naturo',
                        style: GoogleFonts.josefinSans(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Sports')
                          ? category.remove('Sports')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Sports');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: category.contains('Sports')
                            ? Colors.purple
                            : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Sports',
                        style: GoogleFonts.josefinSans(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Travel')
                          ? category.remove('Travel')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Travel');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: category.contains('Travel')
                            ? Colors.purple
                            : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Travel',
                        style: GoogleFonts.josefinSans(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Art')
                          ? category.remove('Art')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Art');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: category.contains('Art')
                            ? Colors.purple
                            : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Art',
                        style: GoogleFonts.josefinSans(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Science')
                          ? category.remove('Science')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Science');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: category.contains('Science')
                            ? Colors.purple
                            : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Science',
                        style: GoogleFonts.josefinSans(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Books')
                          ? category.remove('Books')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Books');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: category.contains('Books')
                            ? Colors.purple
                            : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Books',
                        style: GoogleFonts.josefinSans(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Mystery')
                          ? category.remove('Mystery')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Mystery');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: category.contains('Mystery')
                            ? Colors.purple
                            : Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Mystery',
                        style: GoogleFonts.josefinSans(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          category.contains('Music')
                              ? category.remove('Music')
                              : print('no');
                          // is_selected = !is_selected;
                        });
                        category.add('Music');
                        print(category);
                      },
                      child: Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: category.contains('Music')
                                ? Colors.purple
                                : Colors.black,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Music',
                            style: GoogleFonts.josefinSans(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        category.contains('Fashion')
                            ? category.remove('Fashion')
                            : print('no');
                        // is_selected = !is_selected;
                      });
                      category.add('Fashion');
                      print(category);
                    },
                    child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Fashion')
                              ? Colors.purple
                              : Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Fashion',
                          style: GoogleFonts.josefinSans(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          category.contains('Act')
                              ? category.remove('Act')
                              : print('no');
                        });
                        category.add('Act');
                        print(category);
                      },
                      child: Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: category.contains('Act')
                                ? Colors.purple
                                : Colors.black,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Act',
                            style: GoogleFonts.josefinSans(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: GestureDetector(
                onTap: () {
                  agecontroller.text.isEmpty &&
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
                            'username':
                                Meetup.sharedPreferences.getString("username"),
                            'imageurl': url,
                            'age': agecontroller.text,
                            'intrest': category,
                            'gender': gender,
                          }).whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: SubCategory(
                                      intrest: category,
                                    ),
                                    type: PageTransitionType.rightToLeft));
                          });
                        });
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    height: 60,
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
            )
          ],
        ),
      ),
    );
  }
}
