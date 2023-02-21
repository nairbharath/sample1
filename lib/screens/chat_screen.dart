// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mentor_mind/screens/group_members.dart';
import 'package:mentor_mind/utils/reciever.dart';
import 'package:mentor_mind/utils/send_message.dart';
import 'package:mentor_mind/utils/sender.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.roomID,
      required this.mentorID,
      required this.requestID,
      required this.admin});
  final String roomID;
  final String requestID;
  final String mentorID;
  final int admin;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _message = TextEditingController();
  // late Map<String, dynamic> snap = {};
  // Future getMentorDetails() async {
  //   CollectionReference users = _firestore.collection('users');
  //   FutureBuilder(
  //     future: users.doc(widget.mentorID).get(),
  //     builder: (((context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }

  //       if (snapshot.connectionState == ConnectionState.done) {
  //         snap = snapshot.data!.data() as Map<String, dynamic>;
  //       }
  //       return const Placeholder();
  //     })),
  //   );
  // }

  void sendMessage() async {
    Map<String, dynamic> message = {
      "by": user.uid,
      "message": _message.text,
      "time": DateTime.now(),
    };
    try {
      await _firestore
          .collection('chats')
          .doc(widget.roomID)
          .collection('messages')
          .add(message);
    } catch (e) {
      print(e.toString());
    }
    _message.clear();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = _firestore.collection('users');

    return FutureBuilder(
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
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              body: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(CupertinoIcons.back)),
                  title: Row(
                    children: [
                      snap['status'] == 'online'
                          ? Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            )
                          : Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                      SizedBox(
                        width: 10,
                      ),
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
                    ],
                  ),
                  centerTitle: true,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: widget.admin == 1
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => GroupMembers(
                                          roomID: widget.roomID,
                                          requestID: widget.requestID,
                                        )));
                              },
                              child: Icon(
                                CupertinoIcons.person_add,
                              ),
                            )
                          : Container(),
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 150,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('chats')
                              .doc(widget.roomID)
                              .collection('messages')
                              .orderBy("time", descending: false)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data != null) {
                              return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> snap =
                                        snapshot.data.docs[index].data()
                                            as Map<String, dynamic>;
                                    if (snap['by'] == user.uid) {
                                      return RecieverBox(
                                          message: snap['message']);
                                    } else {
                                      return SenderBox(
                                          message: snap['message']);
                                    }
                                  });
                            } else {
                              return Center(
                                child: LoadingAnimationWidget.waveDots(
                                    color: Colors.white, size: 40),
                              );
                            }
                          },
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SenderBox(message: 'Hi how are you?'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // RecieverBox(message: 'I am fine thanks ❤️'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SenderBox(message: "I'd like to meet at 10:00 AM"),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // RecieverBox(message: 'Ofcourse!'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SenderBox(
                      //   message:
                      //       'Hi how are you? Hi how are you? Hi how are you? Hi how are you?Hi how are you?',
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // RecieverBox(message: 'I am fine thanks ❤️'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SenderBox(message: "I'd like to meet at 10:00 AM"),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // RecieverBox(message: 'Ofcourse!'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SenderBox(message: 'Hi how are you?'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // RecieverBox(message: 'I am fine thanks ❤️'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SenderBox(message: "I'd like to meet at 10:00 AM"),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // RecieverBox(message: 'Ofcourse!'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SenderBox(message: 'Hi how are you?'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // RecieverBox(message: 'I am fine thanks ❤️'),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SenderBox(message: "I'd like to meet at 10:00 AM"),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // RecieverBox(message: 'Ofcourse!'),
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext subcontext) {
                                  return Container(
                                    height: 300,
                                    child: EmojiSelector(
                                      withTitle: true,
                                      onSelected: (emoji) {
                                        Navigator.of(subcontext).pop(emoji);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(CupertinoIcons.smiley)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(CupertinoIcons.mic_fill),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF3a3f54),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                controller: _message,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'write message..',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: sendMessage,
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF6a65fd),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  CupertinoIcons.rocket,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const Placeholder();
      })),
    );
  }
}
