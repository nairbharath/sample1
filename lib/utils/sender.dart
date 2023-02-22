// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SenderBox extends StatefulWidget {
  SenderBox({
    super.key,
    required this.message,
    required this.type,
    required this.uid,
  });
  final String message;
  final String type;
  final String uid;

  @override
  State<SenderBox> createState() => _SenderBoxState();
}

class _SenderBoxState extends State<SenderBox> {
  final audioPlayer = AudioPlayer();

  bool isplaying = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.network(
              'https://avatars.dicebear.com/api/identicon/${widget.uid}.svg',
              width: 20,
              height: 20,
            )),
        SizedBox(
          width: 10,
        ),
        widget.type == 'text'
            ? Flexible(
                child: Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFF3a3f54),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Text(
                      widget.message,
                    )),
                  ),
                ),
              )
            : Container(
                width: 50,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Color(0xFF3a3f54),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        audioPlayer.play(UrlSource(widget.message));
                        setState(() {
                          isplaying = true;
                        });
                        audioPlayer.onPlayerComplete.listen((event) {
                          setState(() {
                            isplaying = false;
                          });
                        });
                      },
                      child: isplaying == false
                          ? Icon(
                              Icons.play_arrow,
                            )
                          : Icon(
                              Icons.pause,
                            ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
