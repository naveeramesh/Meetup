import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/ChatRoom.dart';
import 'package:page_transition/page_transition.dart';

class Info extends StatefulWidget {
  final QueryDocumentSnapshot snapshots;
  const Info({Key key, this.snapshots}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  List userintrest = [];
  getintrest() async {
    FirebaseFirestore.instance.collection('Category').get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          userintrest.add(element.data()['intrest']);
          print(userintrest);
        });
      });
    });
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getintrest();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:20.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: ChatRoom(
                                info: widget.snapshots['username'],
                                image: widget.snapshots['imageurl'],
                              ),
                              type: PageTransitionType.leftToRight));
                    },
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.chat),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
