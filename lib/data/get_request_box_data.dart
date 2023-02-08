import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mind/screens/description.dart';
import 'package:mentor_mind/utils/request_box.dart';
import 'package:mentor_mind/utils/request_box_with_edit.dart';

class GetRequestBoxData extends StatelessWidget {
  GetRequestBoxData({super.key, required this.docID});

  final String docID;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    CollectionReference requests = _firestore.collection('requests');
    return FutureBuilder<DocumentSnapshot>(
        future: requests.doc(docID).get(),
        builder: (((context, snapshot) {
          print('calling' + docID);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text(''),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> snap =
                snapshot.data!.data() as Map<String, dynamic>;

            return RequestBoxWithEdit(
              dSnap: snap,
              col: Colors.primaries[Random().nextInt(
                Colors.primaries.length,
              )],
            );
          }
          return CircularProgressIndicator();
        })));

    ;
  }
}
