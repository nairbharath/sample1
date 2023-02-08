import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mentor_mind/screens/homescreen.dart';
import 'package:mentor_mind/utils/apply_box.dart';
import 'package:mentor_mind/utils/category_box.dart';
import 'package:mentor_mind/utils/description_box.dart';
import 'package:mentor_mind/utils/request_box.dart';
import 'package:mentor_mind/utils/skills_box.dart';

class Description extends StatefulWidget {
  Description({super.key, required this.dSnap});
  var dSnap;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser!;

  Future applyToTeach() async {
    try {
      await _firestore.collection('users').doc(user.uid).update({
        'applied': FieldValue.arrayUnion(
          [widget.dSnap['requestID']],
        ),
      });
    } catch (e) {
      print(e.toString());
    }

    // try {
    //   await _firestore.collection('requests').doc(dSnap['requestID']).update({
    //     'applicants': FieldValue.arrayUnion([user.uid]),
    //   });
    // } catch (e) {
    //   print(e.toString());
    // }

    try {
      await _firestore
          .collection('requests')
          .doc(widget.dSnap['requestID'])
          .update({
        'applicants': FieldValue.arrayUnion(
          [user.uid],
        ),
      });
    } catch (e) {
      print(e.toString());
    }

    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // DocumentReference documentReference =
    //     firestore.collection('requests').doc(dSnap['requestID']);
    // await firestore.runTransaction((Transaction transaction) async {
    //   DocumentSnapshot snapshot = await transaction.get(documentReference);
    //   if (snapshot.exists) {
    //     List<dynamic> applicants = snapshot['applicants'] ?? [];
    //     applicants.add(user.uid);
    //     transaction.update(documentReference, {
    //       'applications': FieldValue.arrayUnion([
    //         {"applicants": applicants}
    //       ])
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.back,
          ),
        ),
        title: Text(
          'Job Details',
        ),
        actions: [
          Icon(
            CupertinoIcons.person_crop_circle_fill,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RequestBox(
              dSnap: widget.dSnap,
              col: Colors.primaries[Random().nextInt(
                Colors.primaries.length,
              )],
            ),
            SizedBox(
              height: 10,
            ),
            DescriptionBox(),
            SizedBox(
              height: 10,
            ),
            RequirementBox(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 30,
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryBox(name: 'Message'),
            GestureDetector(
              onTap: () {
                applyToTeach();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              },
              child: ApplyBox(name: 'Apply Now'),
            ),
          ],
        ),
      ),
    );
  }
}
