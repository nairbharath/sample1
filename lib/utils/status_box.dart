import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mind/screens/mentor_profile.dart';
import 'package:mentor_mind/screens/requested_applicants.dart';
import 'package:mentor_mind/screens/update.dart';
import 'package:mentor_mind/utils/category_box_inside_req.dart';

class ApplicationStatusViewBox extends StatelessWidget {
  ApplicationStatusViewBox({super.key, required this.col, required this.dSnap});
  final user = FirebaseAuth.instance.currentUser!;
  Color col;
  var dSnap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              print(dSnap['mentor']);
              if (dSnap['mentor'] == '' || dSnap['mentor'] == null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RequestedApplicantsPage(
                      requestID: dSnap['requestID'],
                    ),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MentorProfile(mentorID: '123'),
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: col,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 230,
              child: Column(
                children: [
                  Container(
                    height: 180,
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
                                  CupertinoIcons.smiley,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Denny Thomas',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(dSnap['topic']),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CategoryBoxInside(title: '12-Apr'),
                              CategoryBoxInside(title: 'Physics'),
                              CategoryBoxInside(title: 'Theory'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            dSnap['description'],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: dSnap['mentor'] == ''
                          ? Colors.blueGrey[200]
                          : dSnap['mentor'] == user.uid
                              ? Colors.green
                              : Colors.redAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: dSnap['mentor'] == ''
                                ? Text(
                                    'Pending ⌛',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : dSnap['mentor'] == user.uid
                                    ? Text(
                                        'Approved 😃',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'Rejected 😥',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UpdateRequestDetails();
                    },
                  ),
                );
              },
              child: dSnap['mentor'] == ''
                  ? Container(
                      height: 40,
                      width: 170,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(CupertinoIcons.delete),
                          Text('Remove Application'),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: Colors.black,
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
