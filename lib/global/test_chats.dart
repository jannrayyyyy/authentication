// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// var currentUser = FirebaseAuth.instance.currentUser!.uid;
// void refreshChatForCurrentUser() {
//   var chatsDocument = [];
//   FirebaseFirestore.instance
//       .collection('chats')
//       .where('users.$currentUser', isNull: true)
//       .snapshots()
//       .listen((QuerySnapshot snapshot) {
//     chatsDocument = snapshot.docs.map((DocumentSnapshot doc) {
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       Map<String, dynamic> names = data['names'];
//       names.remove(currentUser);
//       // var users = data['users'];
//       return {
//         'docId': doc.id,
//         'name': names.values.first,
//       };
//     }).toList();
//     for (var element in chatsDocument) {
//       FirebaseFirestore.instance
//           .collection('chats/${element['docId']}/messages')
//           .orderBy('createdOn', descending: true)
//           .limit(1)
//           .snapshots()
//           .listen((event) {
//         if (snapshot.docs.isNotEmpty) {
//           messages[doc['name']] = {
//             'msg': snapshot.docs.first['msg'],
//             'time': snapshot.docs.first['createdOn'],
//             'friendName': doc['name'],
//             'friendUid': snapshot.docs.first['uid']
//           };
//         }
//       });
//     }
//   });
// }
