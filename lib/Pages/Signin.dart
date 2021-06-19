import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Error/AlertErrorDialog.dart';
import 'package:meet_ups/Pages/Login.dart';
import 'package:meet_ups/Pages/ageabout.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';

class Signin extends StatefulWidget {
  const Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isloading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  Future<void> _signin() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isloading = true;
      });
      User firebaseUser;

      await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passwordcontroller.text.trim())
          .then((auth) {
        firebaseUser = auth.user;
      }).catchError((error) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (c) {
              return AlertErrorDialog(message: error.message.toString());
            });
      });
      if (firebaseUser != null) {
        uploaddata(firebaseUser).then((value) {
          Route route = MaterialPageRoute(builder: (c) => About());
          Navigator.pushReplacement(context, route);
        });
      }
    }
  }

  uploaddata(User user) async {
    FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
      "uid": user.uid,
      "email": user.email,
      "username": usernamecontroller.text.trim(),
    });
    Meetup.sharedPreferences.setString("uid", user.uid);
    Meetup.sharedPreferences.setString("email", user.email);
    Meetup.sharedPreferences
        .setString("username", usernamecontroller.text.trim())
        .then((value) {
      print('Firebase set properly');
      print(user.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(width: 500),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  'Meet Up'.toUpperCase(),
                  style: GoogleFonts.josefinSans(
                      fontSize: 30,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 3,
                width: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.purple, Colors.pinkAccent])),
              ),
              SizedBox(
                height: 40,
              ),
              Text("Find your'e twin soul",
                  style: GoogleFonts.josefinSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  )),
              SizedBox(
                height: 40,
              ),
              // Container(
              //   height: 100,
              //   child: Lottie.network(
              //       'https://assets10.lottiefiles.com/packages/lf20_5Vz7xX.json'),
              // ),
              // SizedBox(
              //   height: 40,
              // ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 30.0, right: 30),
                        child: TextFormField(
                          validator: (val) {
                            return val.length < 4
                                ? 'Provide a valid username'
                                : null;
                          },
                          cursorColor: Colors.purple,
                          style: GoogleFonts.josefinSans(color: Colors.black),
                          controller: usernamecontroller,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'Username',
                              hintStyle: GoogleFonts.josefinSans(
                                  color: Colors.grey, letterSpacing: 1)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30),
                        child: TextFormField(
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val)
                                ? null
                                : "Please provide a valid email";
                          },
                          cursorColor: Colors.purple,
                          style: GoogleFonts.josefinSans(
                            color: Colors.black,
                          ),
                          controller: emailcontroller,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'Email',
                              hintStyle: GoogleFonts.josefinSans(
                                  color: Colors.grey, letterSpacing: 1)),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 30.0, right: 30),
                        child: TextFormField(
                          validator: (val) {
                            return val.length < 4
                                ? 'Provide a strong password'
                                : null;
                          },
                          cursorColor: Colors.purple,
                          style: GoogleFonts.josefinSans(color: Colors.black),
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'Password',
                              hintStyle: GoogleFonts.josefinSans(
                                  color: Colors.grey, letterSpacing: 1)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                    ),
                    GestureDetector(
                      onTap: () {
                        _signin();
                      },
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Colors.purple,
                            Colors.pinkAccent
                          ]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Register',
                            style: GoogleFonts.josefinSans(
                                color: Colors.white,
                                letterSpacing: 1,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: Login(),
                                type: PageTransitionType.leftToRight));
                      },
                      child: Text('Already an User ? Login',
                          style: GoogleFonts.josefinSans(
                              fontWeight: FontWeight.bold, color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
