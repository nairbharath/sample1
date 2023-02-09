import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_mind/utils/reciever.dart';
import 'package:mentor_mind/utils/send_message.dart';
import 'package:mentor_mind/utils/sender.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(CupertinoIcons.back),
        title: Text(
          'Denny Thomas',
          style: GoogleFonts.getFont(
            'Noto Sans Display',
            textStyle: TextStyle(
              fontSize: 20,
              letterSpacing: .5,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        SizedBox(
          height: 10,
        ),
        SenderBox(),
        SizedBox(
          height: 10,
        ),
        RecieverBox(),
      ]),
      bottomNavigationBar: SendMessageBox(),
    );
  }
}
