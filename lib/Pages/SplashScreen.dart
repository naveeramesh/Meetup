import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/HomeScreen.dart';
import 'package:meet_ups/Pages/Signin.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

String userid = Meetup.sharedPreferences.getString("uid");

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(height: 100, width: 500),
                Container(
                    height: 400, child: Image.asset('assets/images/logo1.png')),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Text(
                    'Meet Up',
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
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Find your'e ",
                        style: GoogleFonts.josefinSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[800],
                        )),
                    Text(
                      'Twin',
                      style: GoogleFonts.josefinSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'soul',
                        style: GoogleFonts.josefinSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: userid == null ? Signin() : HomeScreen(),
                          type: PageTransitionType.fade));
                },
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: <Color>[
                        Colors.purple,
                        Colors.pinkAccent,
                      ])),
                  child: Center(
                      child: Text(
                    'Get Started',
                    style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
