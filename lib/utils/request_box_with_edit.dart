import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mind/screens/mentor_profile.dart';
import 'package:mentor_mind/screens/profilePage.dart';
import 'package:intl/intl.dart';
import 'package:mentor_mind/screens/requested_applicants.dart';
import 'package:mentor_mind/screens/update.dart';
import 'package:mentor_mind/utils/category_box_inside_req.dart';

class RequestBoxWithEdit extends StatelessWidget {
  RequestBoxWithEdit({super.key, required this.col, required this.dSnap});
  Color col;
  var dSnap;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference users = _firestore.collection('users');
    final Timestamp timestamp = dSnap['datetime'] as Timestamp;
    final DateTime dateTime = timestamp.toDate();
    final int difference = DateTime.now().difference(dateTime).inMinutes;
    return FutureBuilder(
        future: users.doc(user.uid).get(),
        builder: (((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text(''),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> snap =
                snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
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
                            builder: (context) => ProfilePageNew(
                              mentorID: dSnap['mentor'],
                            ),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snap['name'],
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
                                      CategoryBoxInside(
                                          title:
                                              '${dSnap["date"]}-${DateFormat("MMM").format(DateTime.now())}'),
                                      // CategoryBoxInside(title: 'Physics'),
                                      CategoryBoxInside(title: dSnap['type']),
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
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.timer,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        difference < 60
                                            ? Text(
                                                'Posted ${difference.toInt()} minutes ago',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            : Text(
                                                'Posted ${(difference / 30).toInt()} hours ago',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '₹ ${dSnap["amount"]}',
                                    style: TextStyle(color: Colors.black),
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
                      child: Container(
                        height: 40,
                        width: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(CupertinoIcons.pencil),
                            Text('Edit'),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        })));
  }
}
