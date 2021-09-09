import 'dart:ui';

import 'package:app_tracker/ui_pages/navigation_tabs.dart';
import 'package:app_tracker/ui_pages/welcome_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => (WelcomeScreen())));
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
                  SignupText(),
                  const SizedBox(height: 20),
                  SignupForm(),
                  const SizedBox(height: 40),
                  SignupButton(),
                ],
              ),
            ),
          ],
        ));
  }
}

class SignupText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Fill the form to signup",
      style: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}

class SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
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
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "abc@gmail.com"),
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
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
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
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
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
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "0311-2233445"),
                ),
              ),
            ],
          ),
        ]);
  }
}

class SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NavigationTabs()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: Colors.blue,
          ),
          child: Text(
            'Sign up',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
