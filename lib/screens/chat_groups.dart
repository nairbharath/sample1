// import 'package:flutter/material.dart';

// class ChatGroups extends StatelessWidget {
//   ChatGroups({super.key, required this.dSnap});
//   var dSnap;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//         future: users.doc(user.uid).get(),
//         builder: (((context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: Text(''),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> snap =
//                 snapshot.data!.data() as Map<String, dynamic>;
//             if (snap.containsKey('groups')) {
//               if (snap['groups'].length > 0) {
//                 _showIcon = true;
//               } else {
//                 _showIcon = false;
//               }
//             }
//             return Scaffold(
//               backgroundColor: Colors.black,
//               appBar: AppBar(
//                 backgroundColor: Colors.black,
//                 automaticallyImplyLeading: false,
//                 elevation: 0,
//                 title: Text(
//                   'Hello ${snap["name"].toString().split(" ")[0]} 👋',
//                 ),
//                 actions: [
//                   if (_showIcon)
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => ChatGroups(
//                             dSnap: snap,
//                           ),
//                         ),
//                       ),
//                       child: Icon(
//                         CupertinoIcons.chat_bubble_2_fill,
//                       ),
//                     ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => RequestPage(
//                           subjects: types,
//                         ),
//                       ),
//                     ),
//                     child: Icon(
//                       CupertinoIcons.add,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => ProfilePage(),
//                       ),
//                     ),
//                     child: Icon(
//                       CupertinoIcons.person_crop_circle_fill,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                 ],
//               ),
//               body: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   const Text(
//                     'Find Jobs',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontFamily: 'Satoshi',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     height: 40,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: types.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Container(
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       _selectedTopic = types[index];
//                                       _filtertopic = types[index];
//                                     });
//                                   },
//                                   child: CategoryBoxForFilter(
//                                     filterTopic: _filtertopic,
//                                     name: types[index],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         RequestSlider(
//                           selectedTopic: _selectedTopic,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return Container();
//         })));
//   }
// }
