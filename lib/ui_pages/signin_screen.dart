import 'dart:ui';

import 'package:app_tracker/services/auth_service.dart';
import 'package:app_tracker/ui_pages/navigation_tabs.dart';
import 'package:app_tracker/ui_pages/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  @override
  SigninScreenState createState() => SigninScreenState();
}

class SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.data != null) return NavigationTabs();
          return SignInView();
        },
      ),
    );
  }
}

class SignInView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SigninText(),
                const SizedBox(height: 20),
                Text(
                  "Email",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: "abc@gmail.com"),
                  ),
                ),
                Text(
                  "password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(hintText: "*****"),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: InkWell(
                    onTap: () async {
                      await Auth().signInWithEmailPassword(
                          emailController.text, passwordController.text);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.blue,
                      ),
                      child: Text(
                        'SignIn',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SignUpButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SigninText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Signup to get  started",
      style: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignupScreen()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.blue,
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
