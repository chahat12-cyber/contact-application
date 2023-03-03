import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> editContact(
    {required String id,
    required String name,
    required String number,
    required String type}) async {
  Map<String, dynamic> data = {'name': name, 'number': number, 'type': type};

  await FirebaseFirestore.instance.collection("contacts").doc(id).update(data);
}
