import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mentor_mind/screens/description.dart';
import 'package:mentor_mind/utils/request_box.dart';

class RequestSlider extends StatefulWidget {
  RequestSlider({super.key, required this.selectedTopic});
  final String selectedTopic;

  @override
  State<RequestSlider> createState() => _RequestSliderState();
}

class _RequestSliderState extends State<RequestSlider> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> requests = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future getRequests() async {
    await _firestore
        .collection('requests')
        .get()
        .then((value) => value.docs.forEach((element) {}));
  }

  Future _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference requests = _firestore.collection('requests');
    return FutureBuilder(
      future: requests.get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.white, size: 40),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            List<dynamic> requests = [];
            snapshot.data!.docs.forEach((element) {
              requests.add(element.data());
            });
            return Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: requests.length,
                itemBuilder: (BuildContext context, int index) {
                  print(widget.selectedTopic.toLowerCase() +
                      " with " +
                      requests[index]['topic'].toString().toLowerCase());
                  if (widget.selectedTopic == '' ||
                      widget.selectedTopic.toLowerCase() ==
                          'All'.toLowerCase()) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Description(
                              dSnap: requests[index],
                            ),
                          ),
                        );
                      },
                      child: RequestBox(
                        dSnap: requests[index],
                        col: Colors.primaries[Random().nextInt(
                          Colors.primaries.length,
                        )],
                      ),
                    );
                  } else {
                    if (requests[index]['topic'].toString().toLowerCase() ==
                        widget.selectedTopic.toLowerCase()) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Description(
                                dSnap: requests[index],
                              ),
                            ),
                          );
                        },
                        child: RequestBox(
                          dSnap: requests[index],
                          col: Colors.primaries[Random().nextInt(
                            Colors.primaries.length,
                          )],
                        ),
                      );
                    }
                  }
                },
              ),
            );
          }
        }
        return Container();
      }),
    );
  }
}
