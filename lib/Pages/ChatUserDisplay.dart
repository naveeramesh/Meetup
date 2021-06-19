import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/ChatRoom.dart';
import 'package:meet_ups/Pages/HomeScreen.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';

class Chatuserdisplay extends StatefulWidget {
  const Chatuserdisplay({Key key}) : super(key: key);

  @override
  _ChatuserdisplayState createState() => _ChatuserdisplayState();
}

class _ChatuserdisplayState extends State<Chatuserdisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Your Chats',
                style: GoogleFonts.josefinSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          )),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('ChatRoom')
                .where('users',
                    arrayContains:
                        Meetup.sharedPreferences.getString('username'))
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                  ),
                );
              } else {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ChatRoom(
                                      info: Meetup.sharedPreferences.getString('username') ==
                                              snapshot.data.docs[index]['users']
                                                  [1]
                                          ? snapshot.data.docs[index]['users']
                                              [0]
                                          : snapshot.data.docs[index]['users']
                                              [1],
                                      image: Meetup.sharedPreferences
                                                  .getString('userimage') ==
                                              snapshot.data.docs[index]
                                                  ['imageurl'][1]
                                          ? snapshot.data.docs[index]['imageurl'][0]
                                          : snapshot.data.docs[index]['imageurl'][1]),
                                  type: PageTransitionType.fade));
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[100], width: 1)),
                          child: Row(children: [
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(Meetup
                                            .sharedPreferences
                                            .getString('userimage') ==
                                        snapshot.data.docs[index]['imageurl'][1]
                                    ? snapshot.data.docs[index]['imageurl'][0]
                                    : snapshot.data.docs[index]['imageurl']
                                        [1])),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              // snapshot.data.docs[index]['users'][1],
                              Meetup.sharedPreferences.getString('username') ==
                                      snapshot.data.docs[index]['users'][1]
                                  ? snapshot.data.docs[index]['users'][0]
                                  : snapshot.data.docs[index]['users'][1],
                              style: GoogleFonts.josefinSans(
                                  color: Colors.purple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
