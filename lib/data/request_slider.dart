// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:mentor_mind/screens/description.dart';
// import 'package:mentor_mind/utils/request_box.dart';

// class RequestSlider extends StatefulWidget {
//   RequestSlider({super.key, required this.selectedTopic});
//   final String selectedTopic;

//   @override
//   State<RequestSlider> createState() => _RequestSliderState();
// }

// class _RequestSliderState extends State<RequestSlider> {
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> requests = [];
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future getRequests() async {
//     await _firestore
//         .collection('requests')
//         .get()
//         .then((value) => value.docs.forEach((element) {}));
//   }

//   Future _handleRefresh() async {
//     return await Future.delayed(Duration(seconds: 2));
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<dynamic> requests = [];

//     CollectionReference requestsRef = _firestore.collection('requests');
//     return FutureBuilder(
//       future: requestsRef.get(),
//       builder: ((context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child:
//                 LoadingAnimationWidget.waveDots(color: Colors.white, size: 40),
//           );
//         } else {
//           if (snapshot.connectionState == ConnectionState.done) {
//             snapshot.data!.docs.forEach((element) {
//               requests.add(element.data());
//             });
//             return Expanded(
//               child: ListView.builder(
//                 cacheExtent: 100,
//                 physics: BouncingScrollPhysics(),
//                 itemCount: requests.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => Description(
//                             dSnap: requests[index],
//                           ),
//                         ),
//                       );
//                     },
//                     child: RequestBox(
//                       type: widget.selectedTopic,
//                       dSnap: requests[index],
//                       col: Colors.primaries[Random().nextInt(
//                         Colors.primaries.length,
//                       )],
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         }
//         return Container();
//       }),
//     );
//   }
// }

//2
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mentor_mind/screens/description.dart';
// import 'package:mentor_mind/utils/request_box.dart';

// class RequestSlider extends StatefulWidget {
//   RequestSlider({super.key, required this.selectedTopic});
//   final String selectedTopic;
//   @override
//   State<RequestSlider> createState() => _RequestSliderState();
// }

// class _RequestSliderState extends State<RequestSlider> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('requests').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }

//         return Expanded(
//           child: ListView.builder(
//             cacheExtent: 100,
//             // physics: BouncingScrollPhysics(),
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               final DocumentSnapshot doc = snapshot.data!.docs[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => Description(
//                         dSnap: doc,
//                       ),
//                     ),
//                   );
//                 },
//                 child: RequestBox(
//                   type: widget.selectedTopic,
//                   dSnap: doc,
//                   col: Colors.primaries[Random().nextInt(
//                     Colors.primaries.length,
//                   )],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentor_mind/screens/description.dart';
import 'package:mentor_mind/utils/request_box.dart';

class RequestSlider extends StatefulWidget {
  RequestSlider({Key? key, required this.selectedTopic}) : super(key: key);

  final String selectedTopic;

  @override
  State<RequestSlider> createState() => _RequestSliderState();
}

class _RequestSliderState extends State<RequestSlider> {
  List<DocumentSnapshot> requests = [];
  late Stream<QuerySnapshot> _requestsStream;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _requestsStream = _firestore
        .collection('requests')
        .where('topic', isEqualTo: widget.selectedTopic)
        .snapshots();
  }

  @override
  void didUpdateWidget(RequestSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTopic != widget.selectedTopic) {
      setState(() {
        requests.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Replace with your desired height
      child: StreamBuilder<QuerySnapshot>(
        stream: _requestsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          requests.addAll(snapshot.data!.docs);

          return ListView.builder(
            cacheExtent: 100,
            physics: BouncingScrollPhysics(),
            itemCount: requests.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot doc = requests[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Description(
                        dSnap: doc,
                      ),
                    ),
                  );
                },
                child: RequestBox(
                  type: widget.selectedTopic,
                  dSnap: doc,
                  col: Colors.primaries[Random().nextInt(
                    Colors.primaries.length,
                  )],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
