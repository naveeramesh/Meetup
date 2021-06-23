import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/HomeScreen.dart';
import 'package:meet_ups/Pages/Info.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                child: HomeScreen(),
                type: PageTransitionType.rightToLeft,
              ));
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.arrow_back),
      ),
      backgroundColor: Colors.white,
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
              child: Text(
                'Notification',
                style: GoogleFonts.josefinSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          )),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 30,
                      width: 50,
                      child: Center(
                        child: Column(
                          children: [
                            Text('Likes',
                                style: GoogleFonts.josefinSans(
                                    color: Colors.black,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              height: 3,
                              width: 20,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: <Color>[
                                Colors.purple,
                                Colors.pinkAccent
                              ])),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      child: Center(
                        child: Column(
                          children: [
                            Text('Request',
                                style: GoogleFonts.josefinSans(
                                    color: Colors.black,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              height: 3,
                              width: 20,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: <Color>[
                                Colors.purple,
                                Colors.pinkAccent
                              ])),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: PageView(children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Likedby')
                        .where('liked',
                            isEqualTo:
                                Meetup.sharedPreferences.getString('username'))
                        // .doc(Meetup.sharedPreferences.getString('username'))
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.purple),
                          ),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 60,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: NetworkImage(snapshot
                                            .data.docs[index]['imageofuser']),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        snapshot.data.docs[index]['name'] +
                                            " liked your'e profile",
                                        style: GoogleFonts.josefinSans(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  height: 200,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Request')
                        .where('requestto',
                            isEqualTo:
                                Meetup.sharedPreferences.getString('username'))
                        // .doc(Meetup.sharedPreferences.getString('username'))
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.purple),
                          ),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: NetworkImage(snapshot
                                            .data
                                            .docs[index]['reqyestedbyimage']),
                                      ),
                                      Text(
                                        snapshot.data.docs[index]
                                                ['requestedby'] +
                                            " requested to text you",
                                        style: GoogleFonts.josefinSans(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            color: Colors.black),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('Accept')
                                              .doc(Meetup.sharedPreferences
                                                  .getString('uid'))
                                              .set({
                                            'accepted': 'yes',
                                            'users': [
                                              Meetup.sharedPreferences
                                                  .getString('username'),
                                            ]
                                          }).whenComplete(() {
                                            Toast.show(
                                                'Accepted the request', context,
                                                duration: Toast.LENGTH_SHORT,
                                                backgroundColor: Colors.purple);
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.purple)),
                                          child: Center(
                                            child: Text(
                                              'Accept',
                                              style: GoogleFonts.josefinSans(
                                                  color: Colors.black,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('Accept')
                                              .doc(Meetup.sharedPreferences
                                                  .getString('uid'))
                                              .set({
                                            'accepted': 'no',
                                            'name': Meetup.sharedPreferences
                                                .getString('username')
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.purple)),
                                          child: Center(
                                            child: Text(
                                              'Cancel',
                                              style: GoogleFonts.josefinSans(
                                                  color: Colors.black,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        );
                      }
                    },
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
