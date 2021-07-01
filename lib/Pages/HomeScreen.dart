import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/Account.dart';
import 'package:meet_ups/Pages/ChatUserDisplay.dart';
import 'package:meet_ups/Pages/Info.dart';
import 'package:meet_ups/Pages/Notifications.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List userintrest = [];
  int likes = 0;
  int chats = 0;
  String imageofuser;

  @override
  void initState() {
    // print(Meetup.sharedPreferences.getString('uid'));
    var firebaseUser = FirebaseAuth.instance.currentUser;
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection('Category')
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      print(value.data());
      print(value.data()['imageurl']);

      setState(() {
        imageofuser = value.data()['imageurl'];
      });
    });

    FirebaseFirestore.instance
        .collection('ChatRoom')
        .where('sendby',
            isEqualTo: Meetup.sharedPreferences.getString('username'))
        .get()
        .then((value) {
      setState(() {
        chats = value.docs.length;
      });
    });

    FirebaseFirestore.instance
        .collection('Likedby')
        .where('liked',
            isEqualTo: Meetup.sharedPreferences.getString('username'))
        .get()
        .then((value) {
      setState(() {
        likes = value.docs.length;
      });
    });
    super.initState();
    // getintrest();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    int counter;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.restart_alt,
            color: Colors.pinkAccent,
          ),
          onPressed: () {
            setState(() {
              counter = 0;
            });
          },
        ),
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: <Color>[Colors.purple.withOpacity(0.8), Colors.pink.withOpacity(0.8)])),
          child: Column(children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: <Color>[Colors.purple, Colors.pink]),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                child: HomeScreen(),
                                type: PageTransitionType.fade,
                              ));
                        },
                        icon: Icon(
                          Icons.whatshot,
                          color: Colors.white,
                        )),
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: Chatuserdisplay(),
                                      type: PageTransitionType.leftToRight));
                              setState(() {
                                chats = 0;
                              });
                            },
                            icon: Icon(Icons.chat, color: Colors.white)),
                        Positioned(
                            top: 10,
                            right: 10,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.red,
                              child: Text(
                                chats.toString() == 0
                                    ? Text('0')
                                    : chats.toString(),
                                style: GoogleFonts.josefinSans(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Column(
                        children: [
                          Text('Discover',
                              style: GoogleFonts.josefinSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                // letterSpacing: 1,
                              )),
                          Container(
                            height: 3,
                            width: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: <Color>[
                              Colors.purple,
                              Colors.pinkAccent
                            ])),
                          )
                        ],
                      ),
                    ),
                    Stack(children: [
                      IconButton(
                          icon: Icon(
                            Icons.notifications_active_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: Notifications(),
                                    type: PageTransitionType.leftToRight));
                            setState(() {
                              likes = 0;
                            });
                          }),
                      Positioned(
                          top: 10,
                          right: 15,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: Colors.red,
                            child: Text(
                              likes.toString() == 0
                                  ? Text('0')
                                  : likes.toString(),
                              style: GoogleFonts.josefinSans(
                                  fontSize: 10, color: Colors.white),
                            ),
                          ))
                    ]),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Account(),
                                  type: PageTransitionType.fade));
                        },
                        icon: Icon(Icons.person, color: Colors.white)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Category')
                        .where('username',
                            isNotEqualTo:
                                Meetup.sharedPreferences.getString('username'))
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.purpleAccent),
                          ),
                        );
                      } else {
                        return Container(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: TinderSwapCard(
                              swipeUp: true,
                              swipeDown: true,
                              orientation: AmassOrientation.BOTTOM,
                              totalNum: snapshot.data.docs.length,
                              stackNum: 3,
                              swipeEdge: 4.0,
                              maxWidth: MediaQuery.of(context).size.width,
                              maxHeight: MediaQuery.of(context).size.height,
                              minWidth: MediaQuery.of(context).size.width * 0.8,
                              minHeight:
                                  MediaQuery.of(context).size.height * 0.8,
                              cardBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                            color: Colors.white12)
                                      ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: Info(
                                                      snapshots: snapshot
                                                          .data.docs[index],
                                                    ),
                                                    type: PageTransitionType
                                                        .fade));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${snapshot.data.docs[index]["imageurl"]}'),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Spacer(),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Text(
                                                    '${snapshot.data.docs[index]['username']},',
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.8),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 40),
                                                  ),
                                                ),
                                                Text(
                                                  '${(snapshot.data.docs[index]['age'])}',
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Likedby')
                                                            .add({
                                                          'name': Meetup
                                                              .sharedPreferences
                                                              .getString(
                                                                  'username'),
                                                          'imageurloflikedperson':
                                                              snapshot.data
                                                                          .docs[
                                                                      index]
                                                                  ['imageurl'],
                                                          'imageofuser':
                                                              imageofuser,
                                                          'liked': snapshot.data
                                                                  .docs[index]
                                                              ['username']
                                                        }).whenComplete(() {
                                                          Toast.show('Liked ❤',
                                                              context,
                                                              duration: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  Toast.BOTTOM);
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.favorite_sharp,
                                                        color: Colors.red[800],
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 300),
                                                    child: Text(
                                                        '${snapshot.data.docs[index]['intrest']}'
                                                            .replaceAll('[', '')
                                                            .replaceAll(
                                                                ']', ''),
                                                        style: GoogleFonts
                                                            .josefinSans(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Icon(
                                                    Icons.location_on_rounded,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Text(
                                                    snapshot.data.docs[index]
                                                        ['location'],
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              cardController: controller = CardController(),
                              swipeUpdateCallback:
                                  (DragUpdateDetails details, Alignment align) {
                                /// Get swiping card's alignment
                                if (align.x < 0) {
                                  //Card is LEFT swiping
                                } else if (align.x > 0) {
                                  //Card is RIGHT swiping
                                }
                              },
                              swipeCompleteCallback:
                                  (CardSwipeOrientation orientation,
                                      int index) {
                                counter = index;
                                print("$counter ${orientation.toString()}");

                                /// Get orientation & index of swiped card!
                              },
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width - 5,
                          height: MediaQuery.of(context).size.height - 220,
                        );
                      }
                    }),
              ),
            ),
            // SizedBox(
            //   height: 100,
            // ),
          ]),
        ));
  }
}
