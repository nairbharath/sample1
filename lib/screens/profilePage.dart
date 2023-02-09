// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentor_mind/screens/chat_screen.dart';

class ProfilePageNew extends StatefulWidget {
  const ProfilePageNew({super.key});

  @override
  State<ProfilePageNew> createState() => _ProfilePageNewState();
}

class _ProfilePageNewState extends State<ProfilePageNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: Icon(CupertinoIcons.back),
      ),
      backgroundColor: Colors.black,
      body: Column(
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
                  'Denny Thomas',
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(),
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
      ),
    );
  }
}
