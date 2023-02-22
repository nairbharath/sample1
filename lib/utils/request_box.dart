import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_mind/utils/category_box_inside_req.dart';

class RequestBox extends StatelessWidget {
  RequestBox(
      {super.key, required this.col, required this.dSnap, required this.type});
  Color col;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String type;
  var dSnap;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = _firestore.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(dSnap['uid']).get(),
        builder: (((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text(''),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> snap =
                snapshot.data!.data() as Map<String, dynamic>;

            final Timestamp timestamp = dSnap['datetime'] as Timestamp;
            final DateTime dateTime = timestamp.toDate();
            final int difference =
                DateTime.now().difference(dateTime).inMinutes;
            print(dSnap['topic']);

            if (type.toLowerCase() == '' ||
                type.toLowerCase() == 'All'.toLowerCase() ||
                dSnap['topic'].toString().toLowerCase() == type.toLowerCase()) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: [
                    Container(
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
                  ],
                ),
              );
            }
          }
          return Container();
        })));
  }
}
