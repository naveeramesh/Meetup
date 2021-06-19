import 'package:cloud_firestore/cloud_firestore.dart';
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
  String userimage;
  List userintrest = [];
  int likes = 1;
  getintrest() async {
    FirebaseFirestore.instance.collection('Category').get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          userintrest.add(element.data()['intrest']);
          print(userintrest);
        });
      });
    });
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Category')
        .doc(Meetup.sharedPreferences.getString('uid'))
        .get()
        .then((value) {
      print(value);
      print(value.data()['imageurl']);
      
      setState(() {
        userimage = value.data()['imageurl'];
        Meetup.sharedPreferences.setString("userimage",userimage);
        print(userimage);
        
      });
    });
    print(Meetup.sharedPreferences.getString('uid'));
    // TODO: implement initState
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
    getintrest();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    int counter;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(Icons.restart_alt),
          onPressed: () {
            setState(() {
              counter = 0;
            });
          },
        ),
        backgroundColor: Colors.white,
        body: Column(children: [
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
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Chatuserdisplay(),
                                type: PageTransitionType.leftToRight));
                      },
                      icon: Icon(Icons.chat, color: Colors.white)),
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
                      }),
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
            height: 40,
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
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: TinderSwapCard(
                            swipeUp: true,
                            swipeDown: true,
                            orientation: AmassOrientation.BOTTOM,
                            totalNum: snapshot.data.docs.length,
                            stackNum: 3,
                            swipeEdge: 4.0,
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                            maxHeight: MediaQuery.of(context).size.height * 0.9,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            minHeight: MediaQuery.of(context).size.height * 0.8,
                            cardBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        color: Colors.grey)
                                  ],
                                ),
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
                                                  type:
                                                      PageTransitionType.fade));
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 450.0),
                                        child: Column(
                                          children: [
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
                                                            .doc(Meetup
                                                                .sharedPreferences
                                                                .getString(
                                                                    'username'))
                                                            .set({
                                                          'name': Meetup
                                                              .sharedPreferences
                                                              .getString(
                                                                  'username'),
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
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      // color: Colors.grey.withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(

                                                        // userintrest[index].toString().replaceAll('[','').replaceAll(']', ''),
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
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Icon(
                                                    Icons.location_on_rounded,
                                                    color: Colors.purple,
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
                                          ],
                                        ),
                                      )
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
                                (CardSwipeOrientation orientation, int index) {
                              counter = index;
                              print("$counter ${orientation.toString()}");

                              /// Get orientation & index of swiped card!
                            },
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width - 30,
                        height: MediaQuery.of(context).size.height - 300,
                      );
                    }
                  }),
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ]));
  }
}
