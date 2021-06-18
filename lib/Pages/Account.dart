import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/HomeScreen.dart';
import 'package:meet_ups/Pages/SplashScreen.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await Meetup.sharedPreferences.clear().whenComplete(() {
      Navigator.pushReplacement(context,
          PageTransition(child: SplashScreen(), type: PageTransitionType.fade));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: HomeScreen(), type: PageTransitionType.fade));
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.purple,
      ),
      appBar: new PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
          child: Container(
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: <Color>[Colors.purple, Colors.pink]),
            ),
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Account Settings',
                    style: GoogleFonts.josefinSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        _signOut();
                      },
                      icon: Icon(Icons.logout, color: Colors.white))
                ],
              ),
            ),
          )),
      backgroundColor: Colors.white,
      body: Container(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Category')
            .where('username',
                isEqualTo: Meetup.sharedPreferences.getString('username'))
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
            ));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                  snapshot.data.docs[index]['imageurl'])),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Icon(Icons.person, color: Colors.purple),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Name : ',
                                style: GoogleFonts.josefinSans(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              snapshot.data.docs[index]['username'],
                              style: GoogleFonts.josefinSans(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Icon(Icons.email, color: Colors.purple),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Email : ',
                                style: GoogleFonts.josefinSans(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              Meetup.sharedPreferences.getString('email'),
                              style: GoogleFonts.josefinSans(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Icon(Icons.location_on, color: Colors.purple),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Loaction : ',
                                style: GoogleFonts.josefinSans(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              snapshot.data.docs[index]['location'],
                              style: GoogleFonts.josefinSans(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
        },
      )),
    );
  }
}
