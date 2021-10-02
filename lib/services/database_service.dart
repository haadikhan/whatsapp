import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCollections {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  Future createUser(String name, String email, String age, String phoneNumber,
      String uid) async {
    await db.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "age": int.tryParse(age),
      "phoneNumber": phoneNumber,
      "uid": uid,
    });
  }

  Future getUser() async {
    User user = FirebaseAuth.instance.currentUser!;
    var userData = await db.collection("users").doc(user.uid).get();
    return userData;
  }
}
