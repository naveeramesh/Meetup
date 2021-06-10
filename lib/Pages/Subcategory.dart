import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/HomeScreen.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';

class SubCategory extends StatefulWidget {
  final List intrest;

  const SubCategory({Key key, this.intrest}) : super(key: key);

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  List subcategory = [];
  // bool is_selected = false;
  @override
  void initState() {
    for (String i in widget.intrest) {
      print(i);
    }
    // TODO: implement initState
    print(widget.intrest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('Users')
              .doc(Meetup.sharedPreferences.getString("uid"))
              .collection('Sub')
              .add({'sub': subcategory}).whenComplete(() {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: HomeScreen(), type: PageTransitionType.fade));
          });
        },
        child: const Icon(Icons.arrow_forward_outlined),
        backgroundColor: Color.fromRGBO(220, 68, 82, 1),
      ),
      backgroundColor: Color.fromRGBO(9, 21, 27, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(2237, 117, 127, 1),
        title: Text(
          'Sub Category',
          style: GoogleFonts.josefinSans(
              color: Colors.white,
              letterSpacing: 1,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: widget.intrest.length,
            itemBuilder: (context, int index) {
              return Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Container(
                    //   child:Text('Select your options',style: GoogleFonts.josefinSans(
                    //     color:Colors.white,
                    //     letterSpacing:1,
                    //     fontWeight:FontWeight.bold

                    //   ),)
                    // ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.grey[800]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text(widget.intrest[index],
                              style: GoogleFonts.josefinSans(
                                color: Color.fromRGBO(227, 127, 117, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('SubCategory')
                              .where('category',
                                  isEqualTo: widget.intrest[index])
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color.fromRGBO(2237, 117, 127, 1)),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          subcategory.contains(snapshot
                                                  .data.docs[index]['name'])
                                              ? subcategory.remove(snapshot
                                                  .data.docs[index]['name'])
                                              : print('no');
                                          // is_selected = !is_selected;
                                        });
                                        subcategory.add(
                                            snapshot.data.docs[index]['name']);
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Container(
                                              height: 30,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: subcategory
                                                              .contains(snapshot
                                                                          .data
                                                                          .docs[
                                                                      index]
                                                                  ['name'])
                                                          ? Colors.red
                                                          : Colors.white
                                                      // is_selected?Colors.red:Colors.white,
                                                      ),
                                                  color: Color.fromRGBO(
                                                      9, 21, 27, 1)),
                                              child: Center(
                                                  child: Text(
                                                snapshot.data.docs[index]
                                                    ['name'],
                                                style: GoogleFonts.josefinSans(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }),
                    ),
                  ]);
              // Container(
              //     height: 60,
              //     width: 100,
              //     decoration: BoxDecoration(
              //       color: Color.fromRGBO(2237, 117, 127, 1),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Center(
              //       child: Text(
              //         'Next',
              //         style: GoogleFonts.josefinSans(
              //             color: Colors.white,
              //             letterSpacing: 1,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   );
            }),
      ),
    );
  }
}
