import 'dart:ui';

import 'package:app_tracker/services/auth_service.dart';
import 'package:app_tracker/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'navigation_tabs.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Sign up",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Text(
                    "Fill the form to signup",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(hintText: "farhad"),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: emailController,
                                decoration:
                                    InputDecoration(hintText: "abc@gm ail.com"),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(hintText: "*****"),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Re enter password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: ageController,
                                decoration: InputDecoration(hintText: "age"),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone no",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: phoneController,
                                decoration:
                                    InputDecoration(hintText: "0311-2233445"),
                              ),
                            ),
                          ],
                        ),
                      ]),
                  const SizedBox(height: 40),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        setState(() => isLoading = true);
                        Auth()
                            .signUpWithEmailPassword(
                                emailController.text, passwordController.text)
                            .whenComplete(() async {
                          User user = FirebaseAuth.instance.currentUser!;
                          await FirebaseCollections().createUser(
                              nameController.text,
                              emailController.text,
                              ageController.text,
                              phoneController.text,
                              user.uid);
                          Navigator.pop(context);
                        }).onError(
                          (error, stackTrace) {
                            setState(() => isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text(error.toString().split("]").last)));
                          },
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationTabs()));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Colors.blue,
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
