import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SenderBox extends StatelessWidget {
  const SenderBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            'https://img.freepik.com/free-photo/spring-beauty-young-beautiful-stylish-female-model-posing-against-pink-background-cross-arms_1258-87903.jpg?w=1380&t=st=1675968044~exp=1675968644~hmac=6b90c1939e6f39a365fee7ba0e4ceb1b9485b0a09e3380a5e19a46bddaf92621',
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
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
            child: Center(child: Text('Hi how are you?')),
          ),
        ),
      ],
    );
  }
}
