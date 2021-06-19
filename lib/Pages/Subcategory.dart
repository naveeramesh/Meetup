import 'package:cloud_firestore/cloud_firestore.dart';
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
                    'Sub Category',
                    style: GoogleFonts.josefinSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('Category')
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
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView.builder(
            itemCount: widget.intrest.length,
            itemBuilder: (context, int index) {
              return Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text(widget.intrest[index],
                              style: GoogleFonts.josefinSans(
                                color: Colors.purple,
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
                                      Colors.purple),
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
                                                    color: subcategory.contains(
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['name'])
                                                        ? Colors.purple
                                                        : Colors.black
                                                    // is_selected?Colors.red:Colors.white,
                                                    ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                snapshot.data.docs[index]
                                                    ['name'],
                                                style: GoogleFonts.josefinSans(
                                                    color: Colors.black),
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
            }),
      ),
    );
  }
}
