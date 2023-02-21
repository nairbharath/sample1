// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupMembers extends StatefulWidget {
  const GroupMembers(
      {super.key, required this.roomID, required this.requestID});
  final String roomID;
  final String requestID;

  @override
  State<GroupMembers> createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  List<dynamic> groupMembers = [];
  Map<String, dynamic>? userMap;
  List<dynamic> result = [];

  void onSearch(String value) async {
    print("running on $value");
    try {
      await _firestore
          .collection('users')
          .where("name", isEqualTo: value)
          .get()
          .then((value) {
        setState(() {
          userMap = value.docs[0].data();
          result.clear();
          result.add(userMap);
        });
        print(userMap);
      });
    } catch (e) {
      print("no such user");
    }
  }

  void addToGroup(String id) async {
    try {
      await _firestore
          .collection('chats')
          .doc(widget.roomID)
          .collection('messages')
          .doc('members')
          .update({
        'members': FieldValue.arrayUnion([id])
      });
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      groupMembers.add(id);
    });

    try {
      await _firestore.collection('users').doc(id).update({
        'groups': FieldValue.arrayUnion(
          [widget.requestID],
        ),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void removeFromGroup(String id) async {
    try {
      await _firestore
          .collection('chats')
          .doc(widget.roomID)
          .collection('messages')
          .doc('members')
          .update({
        'members': FieldValue.arrayRemove([id])
      });
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      groupMembers.remove(id);
    });

    try {
      await _firestore.collection('users').doc(id).update({
        'groups': FieldValue.arrayRemove(
          [widget.requestID],
        ),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference members = _firestore.collection('chats');
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          CupertinoIcons.back,
        ),
        title: Text(
          'Group members',
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: CupertinoSearchTextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                onSubmitted: (value) {
                  print("searched");
                  onSearch(value);
                },
                borderRadius: BorderRadius.circular(10.0),
                placeholder: 'Search names',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: members
                  .doc(widget.roomID)
                  .collection('messages')
                  .doc('members')
                  .get(),
              builder: (((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text('searching...'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> snap =
                      snapshot.data!.data() as Map<String, dynamic>;
                  List<dynamic> groupMembers = [];
                  groupMembers.add(user.uid);

                  for (var x in snap['members']) {
                    groupMembers.add(x);
                  }
                  return Scaffold(
                    body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: groupMembers.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(groupMembers[index].toString()),
                                        groupMembers[index].toString() ==
                                                user.uid
                                            ? Container()
                                            : GestureDetector(
                                                onTap: () {
                                                  removeFromGroup(
                                                      groupMembers[index]
                                                          .toString());
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.red,
                                                ),
                                              ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(result[index]['name']),
                                        result[index]['uid'] == user.uid
                                            ? Container()
                                            : GestureDetector(
                                                onTap: () {
                                                  addToGroup(
                                                      result[index]['uid']);
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.green,
                                                ),
                                              ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ]),
                  );
                }
                return const Placeholder();
              })),
            ),
          ),
        ],
      ),
    );
  }
}
