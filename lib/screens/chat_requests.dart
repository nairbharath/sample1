import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mentor_mind/data/chat_get_request_box_data.dart';
import 'package:mentor_mind/data/get_request_box_data.dart';

class ChatRequestsPage extends StatefulWidget {
  const ChatRequestsPage({super.key});

  @override
  State<ChatRequestsPage> createState() => Personal_RequestsViewState();
}

class Personal_RequestsViewState extends State<ChatRequestsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> requestIDsOfUser = [];

  Future getRequestIDsOfUser() async {
    await _firestore.collection('users').doc(user.uid).get().then((doc) {
      requestIDsOfUser = doc.data()!['groups'];
    });
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
          return Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.white, size: 40),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('chats'),
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
                        return ChatGetRequestBoxData(
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
