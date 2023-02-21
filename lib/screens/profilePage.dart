// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_mind/screens/chat_screen.dart';

class ProfilePageNew extends StatefulWidget {
  ProfilePageNew({super.key, required this.mentorID, this.requestID = ''});
  final String mentorID;
  final String requestID;

  @override
  State<ProfilePageNew> createState() => _ProfilePageNewState();
}

class _ProfilePageNewState extends State<ProfilePageNew> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  String chatRoomID(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2[0].toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = _firestore.collection('users');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text('Your Mentor'),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(CupertinoIcons.back)),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.mentorID).get(),
        builder: (((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text(''),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> snap =
                snapshot.data!.data() as Map<String, dynamic>;
            print(snap);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF0A2647).withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    height: 300.0,
                    width: 300.0,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFF144272).withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      height: 300.0,
                      width: 300.0,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF205295).withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        height: 300.0,
                        width: 300.0,
                        child: Container(
                            margin: EdgeInsets.all(20),
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF2C74B3).withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://img.freepik.com/free-photo/spring-beauty-young-beautiful-stylish-female-model-posing-against-pink-background-cross-arms_1258-87903.jpg?w=1380&t=st=1675968044~exp=1675968644~hmac=6b90c1939e6f39a365fee7ba0e4ceb1b9485b0a09e3380a5e19a46bddaf92621',
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        snap['name'],
                        style: GoogleFonts.getFont(
                          'Noto Sans Display',
                          textStyle: TextStyle(
                            fontSize: 20,
                            letterSpacing: .5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.star_fill,
                            color: Color(0xFFFFC4DD),
                          ),
                          Icon(
                            CupertinoIcons.star_fill,
                            color: Color(0xFFFFC4DD),
                          ),
                          Icon(
                            CupertinoIcons.star_fill,
                            color: Color(0xFFFFC4DD),
                          ),
                          Icon(
                            CupertinoIcons.star_fill,
                            color: Color(0xFFFFC4DD),
                          ),
                          Icon(
                            CupertinoIcons.star_lefthalf_fill,
                            color: Color(0xFFFFC4DD),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '4.3 out of 5.0',
                        style: GoogleFonts.getFont(
                          'Noto Sans Display',
                          textStyle: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        String roomID = chatRoomID(user.uid, widget.mentorID);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              admin: 1,
                              requestID: widget.requestID,
                              roomID: roomID,
                              mentorID: widget.mentorID,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFFC4DD),
                        ),
                        child: Icon(
                          CupertinoIcons.chat_bubble,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFeef2f5),
                      ),
                      child: Icon(
                        CupertinoIcons.videocam_circle_fill,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFC4DD),
                      ),
                      child: Icon(
                        CupertinoIcons.mic_circle_fill,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return Container();
        })),
      ),
    );
  }
}
