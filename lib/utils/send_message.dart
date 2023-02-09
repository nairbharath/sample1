import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            Icon(CupertinoIcons.smiley),
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
