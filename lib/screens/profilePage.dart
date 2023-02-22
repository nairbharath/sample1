// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_mind/screens/chat_screen.dart';
import 'package:mentor_mind/screens/rate.dart';
import 'package:url_launcher/url_launcher.dart';

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
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.network(
                                    'https://avatars.dicebear.com/api/identicon/${widget.mentorID}.svg',
                                    width: 75,
                                    height: 75,
                                  )),
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
                        '${snap["rating"].toStringAsFixed(2)} out of 5.0',
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
                      child: GestureDetector(
                        onTap: () async {
                          final String phoneNumber = '1234567890'.trim();
                          final Uri phoneCall =
                              Uri(scheme: 'tel', path: phoneNumber);
                          try {
                            if (await canLaunch(phoneCall.toString())) {
                              await launch(phoneCall.toString());
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        child: Icon(
                          CupertinoIcons.phone_circle_fill,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        String roomID = chatRoomID(user.uid, widget.mentorID);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => Rating(
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
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.creditCard,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
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
