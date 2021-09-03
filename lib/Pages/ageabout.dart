import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/Intrest.dart';
import 'package:meet_ups/Pages/Profile.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  TextEditingController agecontroller = TextEditingController();
  String gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          agecontroller.text.isEmpty
              ? Toast.show('Please fill the respective age', context,
                  duration: Toast.LENGTH_SHORT, backgroundColor: Colors.purple)
              : Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: Intrest(
                        gender: gender,
                        age: agecontroller.text,
                      ),
                      type: PageTransitionType.leftToRight));
        },
        child: Icon(Icons.arrow_forward),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 50),
                child: Row(
                  children: [
                    Text(
                      "You are ?",
                      style: GoogleFonts.josefinSans(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: gender == "Female"
                                ? LinearGradient(
                                    colors: <Color>[Colors.purple, Colors.pink])
                                : LinearGradient(colors: <Color>[
                                    Colors.grey,
                                    Colors.white
                                  ])),
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Container(
                                child: IconButton(
                              icon: Icon(
                                Icons.female,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  gender = "Female";
                                });
                              },
                            ))),
                      ),
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
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: gender == "Male"
                                ? LinearGradient(
                                    colors: <Color>[Colors.purple, Colors.pink])
                                : LinearGradient(colors: <Color>[
                                    Colors.grey,
                                    Colors.white
                                  ])),
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Container(
                                child: IconButton(
                              icon: Icon(
                                Icons.male,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  gender = "Male";
                                });
                              },
                            ))),
                      ),
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
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: gender == "Other"
                                ? LinearGradient(
                                    colors: <Color>[Colors.purple, Colors.pink])
                                : LinearGradient(colors: <Color>[
                                    Colors.grey,
                                    Colors.white
                                  ])),
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Container(
                                child: IconButton(
                              icon: Icon(
                                Icons.circle,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  gender = "Other";
                                });
                              },
                            ))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Other',
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
                      "Your'e age",
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
            ],
          ),
        ),
      ),
    );
  }
}
