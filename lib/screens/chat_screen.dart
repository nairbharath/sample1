// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mentor_mind/model/sound_player.dart';
import 'package:mentor_mind/model/sound_recorder.dart';
import 'package:mentor_mind/model/storage.dart';
import 'package:mentor_mind/model/upload.dart';
import 'package:mentor_mind/screens/group_members.dart';
import 'package:mentor_mind/utils/reciever.dart';
import 'package:mentor_mind/utils/send_message.dart';
import 'package:mentor_mind/utils/sender.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

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
  final recorder = SoundRecorder();
  final player = SoundPlayer();
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    recorder.init();
    player.init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
    recorder.dispose();
  }

  Future uploadVoice() async {
    int c = 0;
    UploadTask? task;
    print(
        '------------------------------------starting upppppppppppppppppppppp-----------------');
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;
    String voiceID = const Uuid().v1();

    final file = File('/data/user/0/com.example.mentor_mind/cache/audio.aac');
    final destination = 'voices/$voiceID';
    print('checking for voice' + file.path);
    if (file.existsSync()) {
      print("exists: ");
      print(destination);
      print(file.path);
      task = FirebaseApi.uploadFile(destination, file);
      final snapshot = await task!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      c += 1;
      print(urlDownload);
      print(c);
      await sendVoice(urlDownload);
    } else {
      print("does not exist: ");
    }
  }

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

  Future sendVoice(String url) async {
    Map<String, dynamic> message = {
      "by": user.uid,
      "url": url,
      "type": 'voice',
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
    bool _isrecording = recorder.isRecording;
    CollectionReference users = _firestore.collection('users');

    return ChangeNotifierProvider(
      create: (_) => ChatState(),
      child: FutureBuilder(
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
                      GestureDetector(
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
                          child: Icon(Icons.call)),
                      SizedBox(
                        width: 20,
                      ),
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
                      ],
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Consumer<ChatState>(
                              builder: (context, chatState, child) {
                            final color = chatState.isIconPressed
                                ? Colors.green
                                : Colors.transparent;
                            return Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color,
                              ),
                            );
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          Consumer<ChatState>(
                            builder: (context, chatState, child) {
                              final color = chatState.isIconPressed
                                  ? Colors.blue
                                  : Colors.grey;

                              return IconButton(
                                icon: Icon(Icons.mic),
                                color: color,
                                onPressed: () async {
                                  chatState.toggleIcon();
                                  final isRecoring =
                                      await recorder.toggleRecording();
                                  // await player.togglePlay(whenFinished: () {});
                                  // audioPlayer.play(UrlSource(
                                  //     'https://firebasestorage.googleapis.com/v0/b/mentor-mind-235df.appspot.com/o/events%2Fcat?alt=media&token=136d61f2-03c0-4ade-9bf2-12fb7d50b52d'));
                                },
                              );
                            },
                          ),
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
                            onTap: () {
                              if (!_message.text.isEmpty) sendMessage();
                              uploadVoice();
                            },
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
      ),
    );
  }
}

class ChatState extends ChangeNotifier {
  bool _isIconPressed = false;

  bool get isIconPressed => _isIconPressed;

  void toggleIcon() {
    _isIconPressed = !_isIconPressed;
    notifyListeners();
  }
}
