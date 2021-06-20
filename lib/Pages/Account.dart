import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/Appinfo.dart';
import 'package:meet_ups/Pages/HomeScreen.dart';
import 'package:meet_ups/Pages/LikedPosts.dart';
import 'package:meet_ups/Pages/SplashScreen.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List sub = [];
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await Meetup.sharedPreferences.clear().whenComplete(() {
      Navigator.pushReplacement(context,
          PageTransition(child: SplashScreen(), type: PageTransitionType.fade));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection('Category')
        .doc(Meetup.sharedPreferences.getString('uid'))
        .collection('Sub')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          sub.add(element.data()['sub']);
          print(sub);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         PageTransition(
      //             child: HomeScreen(), type: PageTransitionType.fade));
      //   },
      //   child: Icon(Icons.arrow_back),
      //   backgroundColor: Colors.purple,
      // ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
                height: 180,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.purple, Colors.pink])),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Category')
                      .where('username',
                          isEqualTo:
                              Meetup.sharedPreferences.getString('username'))
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.purpleAccent),
                      ));
                    } else {
                      return Container(
                        child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: <Color>[
                                  Colors.purple,
                                  Colors.pink
                                ])),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.grey,
                                          backgroundImage: NetworkImage(snapshot
                                              .data.docs[index]['imageurl'])),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 50, left: 20.0),
                                              child: Text(
                                                snapshot.data
                                                        .docs[index]['username']
                                                        .toUpperCase() +
                                                    " " +
                                                    ',' +
                                                    " " +
                                                    snapshot.data.docs[index]
                                                        ['age'],
                                                style: GoogleFonts.josefinSans(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
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
                                                  child: Text(
                                                    Meetup.sharedPreferences
                                                        .getString('email')
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
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
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                    size: 10,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    snapshot.data.docs[index]
                                                        ['location'],
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                  },
                )),
            SizedBox(
              height: 50,
            ),
            Text(
              'Your intrest',
              style: GoogleFonts.josefinSans(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20),
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
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Category')
                    .doc(Meetup.sharedPreferences.getString('uid'))
                    .collection('Intrest')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    ));
                  } else {
                    return Container(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Center(
                                        child: Text(
                                          snapshot.data.docs[index]['name'],
                                          style: GoogleFonts.josefinSans(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }));
                  }
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Sub intrest',
              style: GoogleFonts.josefinSans(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20),
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
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Category')
                    .doc(Meetup.sharedPreferences.getString('uid'))
                    .collection('SubIntrestString')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    ));
                  } else {
                    return Container(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Center(
                                        child: Text(
                                          snapshot.data.docs[index]['name'],
                                          style: GoogleFonts.josefinSans(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }));
                  }
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [
                    ListTile(
                        leading:
                            Icon(Icons.favorite_border, color: Colors.black),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: LikedPosts(),
                                      type: PageTransitionType.leftToRight));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black,
                              size: 18,
                            )),
                        title: Text(
                          'Liked posts',
                          style: GoogleFonts.josefinSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 1),
                        )),
                    ListTile(
                        leading: Icon(Icons.info_outline, color: Colors.black),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: Appinfo(),
                                      type: PageTransitionType.leftToRight));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black,
                              size: 18,
                            )),
                        title: Text(
                          'About',
                          style: GoogleFonts.josefinSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 1),
                        )),
                    SizedBox(
                      height: 200,
                    ),
                    GestureDetector(
                      onTap: () {
                        _signOut();
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: <Color>[Colors.purple, Colors.pink])),
                        child: Center(
                            child: Text(
                          'Signout',
                          style: GoogleFonts.josefinSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
