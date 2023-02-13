import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SendMessageBox extends StatefulWidget {
  const SendMessageBox({super.key});

  @override
  State<SendMessageBox> createState() => _SendMessageBoxState();
}

class _SendMessageBoxState extends State<SendMessageBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
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
            Container(
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
          ],
        ),
      ),
    );
  }
}
