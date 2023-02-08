import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CategoryBox extends StatelessWidget {
  CategoryBox({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
