import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String topic;
  final String description;
  final String uid;
  final String subject;
  final String date;
  final String type;
  final String amount;
  final String requestID;
  final List<String> applicants;
  final String mentor;
  final DateTime datetime;

  Request({
    required this.topic,
    required this.description,
    required this.uid,
    required this.subject,
    required this.date,
    required this.type,
    required this.amount,
    required this.requestID,
    this.applicants = const [],
    this.mentor = '',
    required this.datetime,
  });

  Map<String, dynamic> toJson() => {
        'topic': topic,
        'description': description,
        'uid': uid,
        'subject': subject,
        'date': date,
        'type': type,
        'amount': amount,
        'requestID': requestID,
        'applicants': applicants,
        'mentor': mentor,
        'datetime': datetime,
      };

  static Request fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return Request(
      topic: snapshot['topic'],
      description: snapshot['description'],
      uid: snapshot['uid'],
      subject: snapshot['subject'],
      date: snapshot['date'],
      type: snapshot['type'],
      amount: snapshot['amount'],
      requestID: snapshot['requestID'],
      applicants: snapshot['applicants'],
      mentor: snapshot['mentor'],
      datetime: snapshot['datetime'],
    );
  }
}
