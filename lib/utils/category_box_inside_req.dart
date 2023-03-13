import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CategoryBoxInside extends StatelessWidget {
  CategoryBoxInside({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      // padding: EdgeInsets.all(8),
      height: 30,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(0.8),
      ),
      child: Center(
          child: title == 'Theory'
              ? Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
    );
  }
}
