import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RecieverBox extends StatelessWidget {
  const RecieverBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Color(0xFF6a65ff),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: Text('Hi how are you?')),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            'https://img.freepik.com/free-photo/urban-young-hipster-indian-man-fashionable-yellow-sweatshirt-cool-south-asian-guy-wear-hoodie-walking-fall-street_627829-4466.jpg?w=1380&t=st=1675975525~exp=1675976125~hmac=e5c979ff139fe46a09ae1e1154132ddc31de68835f2bca2dd2966e7eab60ff07',
          ),
        ),
      ],
    );
  }
}
