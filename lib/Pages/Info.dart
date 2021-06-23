import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/ChatRoom.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';

class Info extends StatefulWidget {
  final QueryDocumentSnapshot snapshots;
  const Info({Key key, this.snapshots}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String imageofuser;
  String acceptance = " ";
  @override
  void initState() {
    var firebaseuser = FirebaseAuth.instance.currentUser;
    // TODO: implement initState

    FirebaseFirestore.instance
        .collection('Category')
        .doc(Meetup.sharedPreferences.getString('uid'))
        .get()
        .then((value) {
      print(value.data());
      print(value.data()['imageurl']);
      setState(() {
        imageofuser = value.data()['imageurl'];
      });
    });

    FirebaseFirestore.instance
        .collection('Accept')
        .doc(widget.snapshots['uid'])
        .get()
        .then((value) {
      print(value.data());
      print(value.data()['accepted']);
      setState(() {
        acceptance = value.data()['accepted'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            acceptance == 'yes'
                ? Navigator.push(
                    context,
                    PageTransition(
                        child: ChatRoom(
                          info: widget.snapshots['username'],
                          image: widget.snapshots['imageurl'],
                        ),
                        type: PageTransitionType.leftToRight))
                : showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Request your'e friend "),
                          actions: [
                            FlatButton(
                              textColor: Colors.black,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('CANCEL'),
                            ),
                            FlatButton(
                              textColor: Colors.black,
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Request')
                                    .doc(Meetup.sharedPreferences
                                        .getString('uid'))
                                    .set({
                                  'requestedby': Meetup.sharedPreferences
                                      .getString('username'),
                                  'reqyestedbyimage': imageofuser,
                                  'requestto': widget.snapshots['username'],
                                  'requesttoimage': widget.snapshots['imageurl']
                                }).whenComplete(() {
                                  Navigator.pop(context);
                                });
                              },
                              child: Text('Request'),
                            ),
                          ],
                        ));
          },
          backgroundColor: Colors.purple,
          child: Icon(Icons.chat),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: 550,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(widget.snapshots['imageurl']),
                      fit: BoxFit.cover)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    widget.snapshots['username'],
                    style: GoogleFonts.josefinSans(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[Colors.purple, Colors.pink]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        '${(widget.snapshots['age'])} Years old',
                        style: GoogleFonts.josefinSans(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Text(
                          widget.snapshots['intrest']
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', ''),
                          style: GoogleFonts.josefinSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Text('About',
                      style: GoogleFonts.josefinSans(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 300, maxWidth: 400),
                    child: Text(
                      widget.snapshots['about'],
                      style: GoogleFonts.josefinSans(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Colors.purple,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Center(
                    child: Text(
                      widget.snapshots['location'],
                      style: GoogleFonts.josefinSans(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
