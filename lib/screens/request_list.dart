// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class RequestList extends StatefulWidget {
//   const RequestList({super.key});

//   @override
//   State<RequestList> createState() => _RequestListState();
// }

// class _RequestListState extends State<RequestList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scrollbar(
//       showTrackOnHover: true,
//       child: items.isNotEmpty
//           ? ListView.builder(
//               itemCount: items.length,
//               itemBuilder: (_, index) {
//                 if (items.isEmpty) {
//                   return const Image(
//                     image: AssetImage('assets/empty.png'),
//                     fit: BoxFit.cover,
//                   );
//                 }
//                 return Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Slidable(
//                     startActionPane: ActionPane(
//                       motion: const StretchMotion(),
//                       children: [
//                         SlidableAction(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             bottomLeft: Radius.circular(
//                               10,
//                             ),
//                           ),
//                           onPressed: ((context) {
//                             BottomSheet(context, (instant['key']));
//                           }),
//                           backgroundColor: const Color(0xFFBCCEF8),
//                           icon: Icons.edit,
//                         ),
//                         SlidableAction(
//                           onPressed: ((context) {
//                             _delete(instant['key']);
//                           }),
//                           backgroundColor:
//                               const Color.fromARGB(255, 65, 72, 88),
//                           icon: Icons.delete,
//                         ),
//                       ],
//                     ),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             blurRadius: 4,
//                             color: Color(0xFFBCCEF8),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Column(
//                                   children: [
//                                     Container(
//                                       width: 80,
//                                       height: 80,
//                                       decoration: const BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         image: DecorationImage(
//                                           image: AssetImage('assets/dp.png'),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       width: 200,
//                                       child: Text(
//                                         instant['name'],
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: 200,
//                                         child: instant['toNextDay'] == 0
//                                             ? Text(
//                                                 '${instant['eventName']} is Today',
//                                                 style: const TextStyle(
//                                                     fontSize: 12),
//                                               )
//                                             : instant['toNextDay'] == 1
//                                                 ? Text(
//                                                     '${instant['eventName']} is Tomorrow',
//                                                     style: const TextStyle(
//                                                         fontSize: 12),
//                                                   )
//                                                 : Text(
//                                                     '${instant['toNextDay']} Days for ${instant['eventName']}',
//                                                     style: const TextStyle(
//                                                         fontSize: 12),
//                                                   )),
//                                     Text(
//                                       instant['yearKnown']
//                                           ? DateFormat.MMMd()
//                                               .format(instant['date'])
//                                           : formatedDate,
//                                       style: const TextStyle(fontSize: 12),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             instant['yearKnown'] == false
//                                 ? Column(
//                                     children: [
//                                       const Text('Turns'),
//                                       Text(
//                                         '${age + 1}',
//                                         style: GoogleFonts.getFont(
//                                           'Lato',
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 30,
//                                         ),
//                                       )
//                                     ],
//                                   )
//                                 : Column(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             )
//           : const Center(
//               child: Image(
//                 image: AssetImage('assets/empty.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//     );
//   }
// }
