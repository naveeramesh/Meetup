import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/HomeScreen.dart';
import 'package:meet_ups/Pages/Info.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';

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
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Likedby')
                .where('liked',
                    isEqualTo: Meetup.sharedPreferences.getString('username'))
                // .doc(Meetup.sharedPreferences.getString('username'))
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                );
              } else {
                return Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: Info(
                                      
                                    ),
                                    type: PageTransitionType.leftToRight));
                          },
                          child: Container(
                            height: 60,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      snapshot.data.docs[index]['imageofuser']),
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
                          ),
                        );
                      }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
