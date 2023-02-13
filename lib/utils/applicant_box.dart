import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mind/screens/profilePage.dart';

class ApplicantBox extends StatelessWidget {
  ApplicantBox({super.key, required this.dSnap, required this.reqDocID});
  var dSnap;
  final String reqDocID;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  void assignMentor() async {
    await _firestore
        .collection('requests')
        .doc(reqDocID)
        .update({"mentor": dSnap['uid']});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        color: Colors.black54,
        child: ListTile(
          leading: const Icon(CupertinoIcons.person_crop_circle),
          title: Text(dSnap['name']),
          subtitle: Text(dSnap['email']),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  assignMentor();
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (_) => ProfilePageNew()));
                },
                child: const Icon(
                  CupertinoIcons.square_arrow_right_fill,
                  color: Colors.green,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
