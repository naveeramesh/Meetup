import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_ups/Pages/HomeScreen.dart';
import 'package:meet_ups/Services/Sharedpreferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class ChatRoom extends StatefulWidget {
  final String info;
  final String image;
  const ChatRoom({Key key, this.info, this.image}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String userid;
  String getterid;
  String chatroom_id;

  TextEditingController messagecontroller = TextEditingController();
  String name;
String userimage;
  @override
  void initState() {
    // TODO: implement initState

    name = widget.info;
    userid = Meetup.sharedPreferences.getString('username').toLowerCase() +
        "_" +
        name.toLowerCase();
    getterid = name.toLowerCase() +
        "_" +
        Meetup.sharedPreferences.getString('username').toLowerCase();
    readlocal();

    super.initState();
    FirebaseFirestore.instance
        .collection('Category')
        .doc(Meetup.sharedPreferences.getString('uid'))
        .get()
        .then((value) {
      print(value);
      print(value.data()['imageurl']);

      setState(() {
        userimage = value.data()['imageurl'];
        Meetup.sharedPreferences.setString("userimage", userimage);
        print(userimage);
      });
    });
  }

  readlocal() async {
    if (userid.hashCode <= getterid.hashCode) {
      chatroom_id = '$userid-$getterid';
    } else {
      chatroom_id = '$getterid-$userid';
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
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
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: HomeScreen(),
                                  type: PageTransitionType.leftToRight));
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(widget.image)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.info,
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
            child: Column(
          children: [
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height - 150,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('ChatRoom')
                        .doc(chatroom_id)
                        .collection('chat_messages')
                        .orderBy("time")
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
                                controller: scrollController,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 5),
                                    child: Container(
                                      alignment: snapshot.data.docs[index]
                                                  ['sendby'] ==
                                              Meetup.sharedPreferences
                                                  .getString('username')
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: Container(
                                        // height:MediaQuery.of(context).size.height*0.021,
                                        // width:
                                        //     MediaQuery.of(context).size.width *0.4,
                                        //  constraints: BoxConstraints(
                                        //    maxHeight:50,
                                        //  maxWidth:100 ),
                                        decoration: BoxDecoration(
                                            borderRadius: snapshot
                                                            .data.docs[index]
                                                        ['sendby'] ==
                                                    Meetup.sharedPreferences
                                                        .getString('username')
                                                ? BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10))
                                                : BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10)),
                                            color: snapshot.data.docs[index]
                                                        ['sendby'] ==
                                                    Meetup.sharedPreferences
                                                        .getString('username')
                                                ? Colors.purple
                                                : Colors.pink),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                          child: Text(
                                              snapshot.data.docs[index]
                                                  ['chatmessages'],
                                              style: GoogleFonts.josefinSans(
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                      }
                    }),
              ),
            ),
            TextField(
              controller: messagecontroller,
              style: GoogleFonts.josefinSans(color: Colors.black),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        messagecontroller.text.isEmpty
                            ? Toast.show('Write a msg to send', context,
                                duration: Toast.LENGTH_LONG,
                                backgroundColor: Colors.purple,
                                gravity: Toast.BOTTOM,
                                textColor: Colors.white)
                            : FirebaseFirestore.instance
                                .collection('ChatRoom')
                                .doc(chatroom_id)
                                .set({
                                // 'messagedby': Meetup.sharedPreferences
                                //     .getString('username'),
                                'users': [
                                  Meetup.sharedPreferences
                                      .getString('username'),
                                  name
                                ],
                                'chatroomid': chatroom_id,
                                'imageurl': [
                                 userimage,
                                  widget.image
                                ]
                              });
                        FirebaseFirestore.instance
                            .collection('ChatRoom')
                            .doc(chatroom_id)
                            .collection('chat_messages')
                            .add({
                          'username': name,
                          'chatmessages': messagecontroller.text,
                          'time': Timestamp.now().millisecondsSinceEpoch,
                          'sendby':
                              Meetup.sharedPreferences.getString('username'),
                        }).whenComplete(() {
                          messagecontroller.clear();

                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        });
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.purple,
                      )),
                  hintText: 'Text Message',
                  hintStyle: GoogleFonts.josefinSans(color: Colors.black)),
            )
          ],
        )));
  }
}
