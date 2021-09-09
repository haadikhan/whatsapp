import 'dart:ui';

import 'package:app_tracker/ui_pages/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HeadingText(),
            const SizedBox(height: 100),
            GetStartedButton(),
          ],
        ),
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Text(' Welcome ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              )),
          Text('Monitor your usage on social media',
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignupScreen()));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.blue,
                ),
                child: Text('GET STARTED',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}
