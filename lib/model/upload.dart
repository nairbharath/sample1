// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:uuid/uuid.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:mentor_mind/model/storage.dart';

// class Upload {
//   UploadTask? task;
//   Future uploadVoice() async {
//     print(
//         '------------------------------------starting upppppppppppppppppppppp-----------------');
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     final user = FirebaseAuth.instance.currentUser!;
//     String voiceID = const Uuid().v1();

//     final file = File('/data/user/0/com.example.mentor_mind/cache/audio.aac');
//     final destination = 'voices/$voiceID';
//     print('checking for voice' + file.path);
//     if (file.existsSync()) {
//       print("exists: ");
//     } else {
//       print("does not exist: ");
//     }

//     final snapshot = await task!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//     print(urlDownload);
//     return urlDownload;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
