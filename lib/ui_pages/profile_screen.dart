import 'dart:ui';

import 'package:app_tracker/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final userData;

  const Profile({Key? key, this.userData}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            ProfilePictureAndName(userData: widget.userData),
            ProfileDetails(),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}

class ProfilePictureAndName extends StatelessWidget {
  final userData;

  const ProfilePictureAndName({Key? key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(90),
          margin: EdgeInsets.symmetric(vertical: 15),
        ),
        Text(
          userData['name'],
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
        )
      ],
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final userData;

  const ProfileDetails({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _email(),
        _status(),
        _help(),
        _about(),
      ],
    );
  }

  Widget _email() {
    return ListTile(
      title: Text(
        "Email",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        FirebaseAuth.instance.currentUser!.email.toString(),
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),
      ),
      trailing: InkWell(
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white30,
        ),
      ),
    );
  }

  Widget _status() {
    return ListTile(
      title: Text(
        "Status",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'live',
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),
      ),
      trailing: InkWell(
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white30,
        ),
      ),
    );
  }

  Widget _about() {
    return ListTile(
      title: Text(
        "About",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'know about this app',
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),
      ),
      trailing: InkWell(
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white30,
        ),
      ),
    );
  }

  Widget _help() {
    return ListTile(
      title: Text(
        "Help",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Get help',
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),
      ),
      trailing: InkWell(
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white30,
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          await Auth().logOut();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
          margin: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: Colors.blue,
          ),
          child: Text(
            'Log Out',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
