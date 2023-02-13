import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mind/screens/description.dart';
import 'package:mentor_mind/utils/applicant_box.dart';
import 'package:mentor_mind/utils/request_box.dart';

class GetApplicantData extends StatelessWidget {
  GetApplicantData({super.key, required this.docID, required this.reqID});

  final String docID;
  final String reqID;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = _firestore.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(docID).get(),
        builder: (((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text(''),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> snap =
                snapshot.data!.data() as Map<String, dynamic>;

            return ApplicantBox(
              reqDocID: reqID,
              dSnap: snap,
            );
          }
          return CircularProgressIndicator();
        })));

    ;
  }
}
