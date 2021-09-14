import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollections {
  final db = FirebaseFirestore.instance;

  Future createUser(
      String name, String email, String age, String phoneNumber) async {
    await db.collection("users").add({
      "name": name,
      "email": email,
      "age": int.tryParse(age),
      "phoneNumber": phoneNumber,
    });
  }
}
