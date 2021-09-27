import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Future signUpWithEmailPassword(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future signInWithEmailPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw e;
    }
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
