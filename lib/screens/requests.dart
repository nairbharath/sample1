import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mentor_mind/data/get_request_box_data.dart';

class PersonalRequestsView extends StatefulWidget {
  const PersonalRequestsView({super.key});

  @override
  State<PersonalRequestsView> createState() => Personal_RequestsViewState();
}

class Personal_RequestsViewState extends State<PersonalRequestsView> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> requestIDsOfUser = [];

  Future getRequestIDsOfUser() async {
    await _firestore.collection('users').doc(user.uid).get().then((doc) {
      requestIDsOfUser = doc.data()!['requests'];
    });
    print("got first part....---------------------");
    print(requestIDsOfUser);
  }

  // Future getDataOfRequests() async {
  //   // await getDataOfRequests();
  //   for (var x in requestIDsOfUser) {
  //     await _firestore.collection('requesets').doc(x).get().then((value) {
  //       DataOfRequests.add(value);
  //     });
  //   }
  //   print("xxxxxxxxxxxxxxxxxxxxxxxx");
  //   print(DataOfRequests);
  // }

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
          return Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.white, size: 40),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Requests'),
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
                        return GetRequestBoxData(
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
  }
}
