// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Rating extends StatefulWidget {
  const Rating({super.key, required this.mentorID});
  final String mentorID;

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  void addRating() async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(widget.mentorID);
    final docSnapshot = await docRef.get();

    final oldRating = docSnapshot.data()!['rating'];
    final oldReviewCount = docSnapshot.data()!['reviewCount'];

    final newRatingCount = oldReviewCount + 1;
    final newRating = (oldRating * oldReviewCount + stars) / newRatingCount;

    await docRef.update({
      'rating': newRating,
      'reviewCount': newRatingCount,
    });

    Navigator.pop(context);
  }

  int stars = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(
            image: AssetImage('assets/rating.png'),
          ),
          Column(
            children: [
              Text(
                'Rate your',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'experience',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 80,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      stars = 1;
                    });
                    print(stars);
                  },
                  child: stars >= 1
                      ? FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.yellow,
                        )
                      : FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.white,
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      stars = 2;
                    });
                    print(stars);
                  },
                  child: stars >= 2
                      ? FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.yellow,
                        )
                      : FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.white,
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      stars = 3;
                    });
                    print(stars);
                  },
                  child: stars >= 3
                      ? FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.yellow,
                        )
                      : FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.white,
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      stars = 4;
                    });
                  },
                  child: stars >= 4
                      ? FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.yellow,
                        )
                      : FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.white,
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      stars = 5;
                    });
                  },
                  child: stars >= 5
                      ? FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.yellow,
                        )
                      : FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.white,
                        ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              addRating();
            },
            child: Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: Center(child: Text('Send')),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
