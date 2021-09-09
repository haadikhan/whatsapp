import 'dart:ui';

import 'package:app_tracker/ui_pages/navigation_tabs.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  @override
  SigninScreenState createState() => SigninScreenState();
}

class SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (NavigationTabs()),
                ),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Payment",
            style: TextStyle(color: Colors.white),
          ),
        ),
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
                    SigninForm(),
                    const SizedBox(height: 40),
                    SigninButton(),
                  ],
                ),
              ),
            ),
          ],
        ));
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

class SigninForm extends StatelessWidget {
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
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                color: Colors.grey[850],
                child: TextFormField(
                  decoration: InputDecoration(hintText: "*****"),
                ),
              ),
            ],
          ),
        ]);
  }
}

class SigninButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NavigationTabs()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 125, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.grey[700],
          ),
          child: Text(
            'SignIn',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
