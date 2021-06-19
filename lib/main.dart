import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meet_ups/Pages/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Services/Sharedpreferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Meetup.sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp());
  
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meet up',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}
