import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:toast/toast.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({Key key}) : super(key: key);

  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  @override
  Widget build(BuildContext context) {
    String name,age,location;
    TextEditingController namecontroller = TextEditingController();
    TextEditingController agecontroller = TextEditingController();
    TextEditingController newlocationcontroller = TextEditingController();

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
              padding: const EdgeInsets.only(
                left: 20,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit profile',
                    style: GoogleFonts.josefinSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        print(name);
                        print(age);
                        print(location);

                        // FirebaseFirestore.instance
                        //     .collection('Category')
                        //     .doc(Meetup.sharedPreferences.getString('uid'))
                        //     .update({
                        //   'username': namecontroller.text.toString(),
                        //   'age': agecontroller.text.toString(),
                        //   "location": newlocationcontroller.text.toString(),
                        // }).whenComplete(() {
                        //   Toast.show(
                        //     "Your'e profile have been updated",
                        //     context,
                        //     duration: Toast.LENGTH_SHORT,
                        //   );
                        // });
                      },
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ))
                ],
              ),
            ),
          )),
      body: Container(
        child: Column(children: [
          Container(
              height: 180,
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
                            height: 130,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(snapshot
                                          .data.docs[index]['imageurl'])),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              )),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 30.0, right: 30),
              child: TextField(
                cursorColor: Colors.purple,
                style: GoogleFonts.josefinSans(color: Colors.black),
                controller: namecontroller,
                onChanged: (value){

                    name=namecontroller.text.toString();
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: 'Name',
                    hintStyle: GoogleFonts.josefinSans(
                        color: Colors.grey, letterSpacing: 1)),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 30.0, right: 30),
              child: TextField(
                cursorColor: Colors.purple,
                onChanged: (value){
                  age=agecontroller.text.toString();

                },
                style: GoogleFonts.josefinSans(color: Colors.black),
                controller: agecontroller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: 'Age',
                    hintStyle: GoogleFonts.josefinSans(
                        color: Colors.grey, letterSpacing: 1)),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 30.0, right: 30),
              child: TextField(
                cursorColor: Colors.purple,
                onChanged: (value){
                 
                   location=newlocationcontroller.text.toString();
                 
                },
                style: GoogleFonts.josefinSans(color: Colors.black),
                controller: newlocationcontroller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: 'Location',
                    hintStyle: GoogleFonts.josefinSans(
                        color: Colors.grey, letterSpacing: 1)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
