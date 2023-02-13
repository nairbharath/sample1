import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mentor_mind/data/get_applicants_data.dart';

class RequestedApplicantsPage extends StatefulWidget {
  RequestedApplicantsPage({super.key, required this.requestID});
  final String requestID;

  @override
  State<RequestedApplicantsPage> createState() =>
      _RequestedApplicantsPageState();
}

class _RequestedApplicantsPageState extends State<RequestedApplicantsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> requestIDsOfUser = [];

  Future getRequestedApplicantsIDs() async {
    try {
      await _firestore
          .collection('requests')
          .doc(widget.requestID)
          .get()
          .then((doc) {
        requestIDsOfUser = doc.data()!['applicants'];
      });
    } catch (e) {}
  }

  Future _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRequestedApplicantsIDs(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.white, size: 40),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Applicants'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                LiquidPullToRefresh(
                  onRefresh: _handleRefresh,
                  color: Color(0xFFC31DC7),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: requestIDsOfUser.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GetApplicantData(
                          reqID: widget.requestID,
                          docID: requestIDsOfUser[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
    ;
  }
}
