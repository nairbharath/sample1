import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RequirementBox extends StatelessWidget {
  const RequirementBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 150,
        child: Column(
          children: [
            Container(
              height: 150,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black26,
                          ),
                          child: Icon(
                            CupertinoIcons.nosign,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Skills & Requirements',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              // Text('Flutter'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'I need to do my flutter project. So i am looking for students with flutter experience in projects.',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
