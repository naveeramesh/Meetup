import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appinfo extends StatefulWidget {
  const Appinfo({Key key}) : super(key: key);

  @override
  _AppinfoState createState() => _AppinfoState();
}

class _AppinfoState extends State<Appinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        SizedBox(
          height: 50,
        ),
        Container(
            child: Center(
          child: Text('Meet Up',
              style: GoogleFonts.josefinSans(
                  color: Colors.purple,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        )),
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
          height: 30,
        ),
        Container(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: GoogleFonts.josefinSans(color: Colors.black, fontSize: 18,letterSpacing: 1,),
            )),
            Container(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: GoogleFonts.josefinSans(color: Colors.black, fontSize: 18,letterSpacing: 1,)
            )),
            Container(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: GoogleFonts.josefinSans(color: Colors.black, fontSize: 18,letterSpacing: 1,),
            ))
      ]),
    );
  }
}
