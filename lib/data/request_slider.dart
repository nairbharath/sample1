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
    setState(() {
      requests = [];
    });
    await _firestore
        .collection('requests')
        .get()
        .then((value) => value.docs.forEach((element) {
              requests.add(element);
            }));
    requests.forEach((element) {
      print(element.data());
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
      future: getRequests(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.white, size: 40),
          );
        }

        return Expanded(
          child: LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            color: Color(0xFFC31DC7),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: requests.length,
              itemBuilder: (BuildContext context, int index) {
                print("Iam " + widget.selectedTopic);
                if (widget.selectedTopic == '' ||
                    widget.selectedTopic.toLowerCase() == 'All'.toLowerCase()) {
                  print("all are printed");
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
                    print("selected are printed");
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
          ),
        );
      }),
    );
  }
}
