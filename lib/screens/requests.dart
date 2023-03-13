import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mentor_mind/data/get_request_box_data.dart';
import 'package:mentor_mind/utils/request_box_with_edit.dart';

class PersonalRequestsView extends StatefulWidget {
  const PersonalRequestsView({super.key});

  @override
  State<PersonalRequestsView> createState() => Personal_RequestsViewState();
}

class Personal_RequestsViewState extends State<PersonalRequestsView> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> requestIDsOfUser = [];
  List<QueryDocumentSnapshot> documents = [];

  Future getRequestIDsOfUser() async {
    await _firestore.collection('users').doc(user.uid).get().then((doc) {
      requestIDsOfUser = doc.data()!['requests'];
    });
    print("requestIDsOfUser");
    print(requestIDsOfUser);
  }

  Future getRequests(List<dynamic> requestIds) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    List<Future<QuerySnapshot>> futures = [];

    for (String id in requestIds) {
      futures.add(_firestore
          .collection('requests')
          .where('requestID', isEqualTo: id)
          .get());
    }

    List<QuerySnapshot> snapshots = await Future.wait(futures);

    documents = [];

    for (QuerySnapshot snapshot in snapshots) {
      print(snapshot.docs.first);

      try {
        documents.add(snapshot.docs.first);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRequestIDsOfUser(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        if (requestIDsOfUser.isEmpty) {
          return Center(
            child: Text('No requests found.'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Requests'),
            ),
            body: SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 70,
                      child: FutureBuilder(
                        future: getRequests(requestIDsOfUser),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: LoadingAnimationWidget.waveDots(
                                  color: Colors.white, size: 40),
                            );
                          }

                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {}

                          return Expanded(
                            child: ListView.builder(
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data = documents[index]
                                    .data() as Map<String, dynamic>;
                                return RequestBoxWithEdit(
                                  dSnap: data,
                                  col: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      }),
    );
  }
}
