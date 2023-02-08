import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CategoryBoxForFilter extends StatelessWidget {
  CategoryBoxForFilter(
      {super.key, required this.name, required this.filterTopic});
  final String name;
  final String filterTopic;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: name == filterTopic
            ? Color.fromARGB(115, 218, 216, 216)
            : Colors.white,
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: name == filterTopic ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
