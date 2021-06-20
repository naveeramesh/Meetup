import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/Profile.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';

class Intrest extends StatefulWidget {
  final String gender;
  final String age;
  const Intrest({Key key, this.gender, this.age}) : super(key: key);

  @override
  _IntrestState createState() => _IntrestState();
}

class _IntrestState extends State<Intrest> {
  List category = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: Category(
                      gender: widget.gender,
                      age: widget.age,
                      intrests: category,
                    ),
                    type: PageTransitionType.leftToRight));
          },
          backgroundColor: Colors.purple,
          child: Icon(Icons.arrow_forward),
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      'Hello ' +
                          Meetup.sharedPreferences.getString('username') +
                          ' ,',
                      style: GoogleFonts.josefinSans(
                          color: Colors.black,
                          letterSpacing: 1,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
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
            Container(
                height: 300, child: Image.asset('assets/images/logo1.png')),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select your intrests",
                  style: GoogleFonts.josefinSans(
                      color: Colors.purple,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('Category')
                        .doc(Meetup.sharedPreferences.getString('uid'))
                        .collection('Intrest')
                        .doc('Coding')
                        .set({'name': 'Coding'});
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
                    FirebaseFirestore.instance
                        .collection('Category')
                        .doc(Meetup.sharedPreferences.getString('uid'))
                        .collection("Intrest")
                        .doc('Animie')
                        .set({
                      'name': 'Animie',
                    });
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
                    FirebaseFirestore.instance
                        .collection('Category')
                        .doc(Meetup.sharedPreferences.getString('uid'))
                        .collection("Intrest")
                        .doc('Film')
                        .set({
                      'name': 'Film',
                    });
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
                    FirebaseFirestore.instance
                        .collection('Category')
                        .doc(Meetup.sharedPreferences.getString('uid'))
                        .collection("Intrests")
                        .doc('Naturo')
                        .set({
                      'name': 'Naturo',
                    });
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
                    FirebaseFirestore.instance
                        .collection('Category')
                        .doc(Meetup.sharedPreferences.getString('uid'))
                        .collection('Intrest')
                        .doc('Sports')
                        .set({'name': 'Sports'});
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
                    FirebaseFirestore.instance
                        .collection('Category')
                        .doc(Meetup.sharedPreferences.getString('uid'))
                        .collection('Intrest')
                        .doc('Travel')
                        .set({'name': 'Travel'});
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
                    FirebaseFirestore.instance
                        .collection('Category')
                        .doc(Meetup.sharedPreferences.getString('uid'))
                        .collection('Intrest')
                        .doc('Art')
                        .set({'name': 'Art'});
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
                    FirebaseFirestore.instance
                        .collection('Category')
                        .doc(Meetup.sharedPreferences.getString('uid'))
                        .collection('Intrest')
                        .doc('Science')
                        .set({'name': 'Science'});
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
                    FirebaseFirestore.instance
                        .collection('Category')
                        .doc(Meetup.sharedPreferences.getString('uid'))
                        .collection('Intrest')
                        .doc('Books')
                        .set({'name': 'Books'});
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
                    FirebaseFirestore.instance
                        .collection('Category')
                        .doc(Meetup.sharedPreferences.getString('uid'))
                        .collection('Intrest')
                        .doc('Mystery')
                        .set({'name': 'Mystery'});
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
                        FirebaseFirestore.instance
                            .collection('Category')
                            .doc(Meetup.sharedPreferences.getString('uid'))
                            .collection('Intrest')
                            .doc('Music')
                            .set({'name': 'Music'});
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
                      FirebaseFirestore.instance
                          .collection('Categpry')
                          .doc(Meetup.sharedPreferences.getString('uid'))
                          .collection('Intrest')
                          .doc('Fashion')
                          .set({'name': 'Fashion'});
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
                        FirebaseFirestore.instance
                            .collection('Category')
                            .doc(Meetup.sharedPreferences.getString('uid'))
                            .collection('Intrest')
                            .doc('Act')
                            .set({'name': 'Act'});
                        setState(() {
                          category.contains('Act')
                              ? category.remove('Act')
                              : print('no');
                          // is_selected = !is_selected;
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
          ]),
        ));
  }
}
