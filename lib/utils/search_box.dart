import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String placehold;
  const SearchBar({
    Key? key,
    required this.placehold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: CupertinoSearchTextField(
          padding: EdgeInsets.all(15),
          onTap: () => {},
          // Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => NewSearchBox(),
          //       ),
          //     ),

          // showSearch(context: context, delegate: DataSearch());

          borderRadius: BorderRadius.circular(10.0),
          placeholder: placehold),
    );
  }
}
