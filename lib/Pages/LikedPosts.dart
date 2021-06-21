import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';

class LikedPosts extends StatefulWidget {
  const LikedPosts({Key key}) : super(key: key);

  @override
  _LikedPostsState createState() => _LikedPostsState();
}

class _LikedPostsState extends State<LikedPosts> {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Liked Posts',
                    style: GoogleFonts.josefinSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          )),
      body: Container(
        child: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height-100,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Likedby')
                    .where('name',isEqualTo: Meetup.sharedPreferences.getString('username'))
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
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return 
                            Container(
                              height: 60,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(snapshot
                                          .data.docs[index]['imageurloflikedperson']),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "You had liked" +
                                        " " +
                                        snapshot.data.docs[index]['liked'] +
                                        "'s profile",
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
              ))
        ]),
      ),
    );
  }
}
