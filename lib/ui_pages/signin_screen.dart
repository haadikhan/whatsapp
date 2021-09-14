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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn.images.express.co.uk/img/dynamic/59/590x/WhatsApp-Share-Data-Facebook-UK-932113.jpg'),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Column(
                children: [
                  SigninText(),
                  const SizedBox(height: 20),
                  Text(
                    "Email",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.grey[850],
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: "abc@gmail.com"),
                    ),
                  ),
                  Text(
                    "password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.grey[850],
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
                            EdgeInsets.symmetric(horizontal: 125, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
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
      style: TextStyle(color: Colors.grey, fontSize: 16),
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
          padding: EdgeInsets.symmetric(horizontal: 125, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.grey[700],
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
