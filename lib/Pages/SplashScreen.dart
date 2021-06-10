import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:meet_ups/Pages/HomeScreen.dart';
import 'package:meet_ups/Pages/Signin.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

String userid = Meetup.sharedPreferences.getString("email");

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(9, 21, 27, 1),
      body: Column(
        children: [
          Container(
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
                        color: Color.fromRGBO(237, 117, 127, 1)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 3,
                  width: 50,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(237, 117, 127, 1)),
                ),
                SizedBox(
                  height: 40,
                ),
                Text("Find your'e twin soul",
                    style: GoogleFonts.josefinSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
              height: 400,
              child: Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_8jyg6s9f.json')),
          SizedBox(
            height: 100,
          ),
          Container(
            child: Text('Aimed for all to get their twin soul',
                style: GoogleFonts.josefinSans(
                    fontSize: 18, letterSpacing: 1, color: Colors.grey)),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child:  Signin() ,
                      type: PageTransitionType.leftToRight));
            },
            child: Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(220, 68, 82, 1)),
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
        ],
      ),
    );
  }
}
