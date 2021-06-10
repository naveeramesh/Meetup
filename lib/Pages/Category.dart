import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/Subcategory.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class Category extends StatefulWidget {
  const Category({Key key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List category = [];
  String gender;
  TextEditingController agecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(9, 21, 27, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Few steps ago..",
                  style: GoogleFonts.josefinSans(
                    color: Color.fromRGBO(237, 117, 127, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    letterSpacing: 1,
                  ),
                ),
                Icon(Icons.favorite,
                    size: 20, color: Color.fromRGBO(237, 117, 127, 1))
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Choose gender",
                      style: GoogleFonts.josefinSans(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromRGBO(2237, 117, 127, 1),
                        child: IconButton(
                          icon: Icon(
                            Icons.female,
                            size: 30,
                          ),
                          onPressed: () {
                            gender = 'Female';
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Female',
                      style: GoogleFonts.josefinSans(
                          color: Colors.white12,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromRGBO(2237, 117, 127, 1),
                        child: IconButton(
                          icon: Icon(
                            Icons.male,
                            size: 30,
                          ),
                          onPressed: () {
                            gender = 'Male';
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Male',
                      style: GoogleFonts.josefinSans(
                          color: Colors.white12,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromRGBO(2237, 117, 127, 1),
                        child: IconButton(
                          icon: Icon(
                            Icons.transgender,
                            size: 30,
                          ),
                          onPressed: () {
                            gender = 'Transgender';
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Transgender',
                      style: GoogleFonts.josefinSans(
                          color: Colors.white12,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Enter age',
                    style: GoogleFonts.josefinSans(
                      color: Colors.grey,
                      letterSpacing: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              // height: 2,
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 150.0, right: 150),
                child: TextField(
                  style: GoogleFonts.josefinSans(color: Colors.white),
                  controller: agecontroller,
                  cursorColor: Color.fromRGBO(237, 117, 127, 1),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: ' ',
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Select Category',
                  style: GoogleFonts.josefinSans(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ]),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Coding')
                          ? category.remove('Coding')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Coding');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Coding')
                              ? Colors.red
                              : Colors.white,
                        ),
                        color: Color.fromRGBO(9, 21, 27, 1)),
                    child: Center(
                      child: Text(
                        'Coding',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Animie')
                          ? category.remove('Animie')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Animie');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Animie')
                              ? Colors.red
                              : Colors.white,
                        ),
                        color: Color.fromRGBO(9, 21, 27, 1)),
                    child: Center(
                      child: Text(
                        'Animie',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Film')
                          ? category.remove('Film')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Film');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Film')
                              ? Colors.red
                              : Colors.white,
                        ),
                        color: Color.fromRGBO(9, 21, 27, 1)),
                    child: Center(
                      child: Text(
                        'Film',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Naturo')
                          ? category.remove('Naturo')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Naturo');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Naturo')
                              ? Colors.red
                              : Colors.white,
                        ),
                        color: Color.fromRGBO(9, 21, 27, 1)),
                    child: Center(
                      child: Text(
                        'Naturo',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Sports')
                          ? category.remove('Sports')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Sports');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Sports')
                              ? Colors.red
                              : Colors.white,
                        ),
                        color: Color.fromRGBO(9, 21, 27, 1)),
                    child: Center(
                      child: Text(
                        'Sports',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Travel')
                          ? category.remove('Travel')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Travel');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Travel')
                              ? Colors.red
                              : Colors.white,
                        ),
                        color: Color.fromRGBO(9, 21, 27, 1)),
                    child: Center(
                      child: Text(
                        'Travel',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Art')
                          ? category.remove('Art')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Art');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Art')
                              ? Colors.red
                              : Colors.white,
                        ),
                        color: Color.fromRGBO(9, 21, 27, 1)),
                    child: Center(
                      child: Text(
                        'Art',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Science')
                          ? category.remove('Science')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Science');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Science')
                              ? Colors.red
                              : Colors.white,
                        ),
                        color: Color.fromRGBO(9, 21, 27, 1)),
                    child: Center(
                      child: Text(
                        'Science',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Books')
                          ? category.remove('Books')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Books');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Books')
                              ? Colors.red
                              : Colors.white,
                        ),
                        color: Color.fromRGBO(9, 21, 27, 1)),
                    child: Center(
                      child: Text(
                        'Books',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category.contains('Mystery')
                          ? category.remove('Mystery')
                          : print('no');
                      // is_selected = !is_selected;
                    });
                    category.add('Mystery');
                    print(category);
                  },
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: category.contains('Mystery')
                              ? Colors.red
                              : Colors.white,
                        ),
                        color: Color.fromRGBO(9, 21, 27, 1)),
                    child: Center(
                      child: Text(
                        'Mystery',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          category.contains('Music')
                              ? category.remove('Music')
                              : print('no');
                          // is_selected = !is_selected;
                        });
                        category.add('Music');
                        print(category);
                      },
                      child: Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: category.contains('Music')
                                  ? Colors.red
                                  : Colors.white,
                            ),
                            color: Color.fromRGBO(9, 21, 27, 1)),
                        child: Center(
                          child: Text(
                            'Music',
                            style: GoogleFonts.josefinSans(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        category.contains('Fashion')
                            ? category.remove('Fashion')
                            : print('no');
                        // is_selected = !is_selected;
                      });
                      category.add('Fashion');
                      print(category);
                    },
                    child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: category.contains('Fashion')
                                ? Colors.red
                                : Colors.white,
                          ),
                          color: Color.fromRGBO(9, 21, 27, 1)),
                      child: Center(
                        child: Text(
                          'Fashion',
                          style: GoogleFonts.josefinSans(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          category.contains('Act')
                              ? category.remove('Act')
                              : print('no');
                        });
                        category.add('Act');
                        print(category);
                      },
                      child: Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: category.contains('Act')
                                  ? Colors.red
                                  : Colors.white,
                            ),
                            color: Color.fromRGBO(9, 21, 27, 1)),
                        child: Center(
                          child: Text(
                            'Act',
                            style: GoogleFonts.josefinSans(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: GestureDetector(
                onTap: () {
                  agecontroller.text.isEmpty
                      ? Toast.show(
                          'Please fill your respective age',
                          context,
                          backgroundColor: Color.fromRGBO(220, 68, 82, 1),
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                        )
                      : FirebaseFirestore.instance
                          .collection('Users')
                          .doc(Meetup.sharedPreferences.getString("uid"))
                          .collection('Category')
                          .add({
                          'age': agecontroller.text.toString(),
                          'intrest': category,
                          'gender': gender,
                        }).whenComplete(() {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: SubCategory(
                                    intrest: category,
                                  ),
                                  type: PageTransitionType.rightToLeft));
                        });
                },
                child: Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(2237, 117, 127, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Next',
                      style: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
