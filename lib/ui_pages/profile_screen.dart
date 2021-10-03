import 'dart:ui';

import 'package:app_tracker/services/auth_service.dart';
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
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    'https://scontent.fkhi11-1.fna.fbcdn.net/v/t1.18169-9/12096526_111858052505168_6802344812800986263_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeEt2-BsRXbKFNgFk9b1JFwPXlTvcOKudIBeVO9w4q50gI6TKxFfawDvuKNbrF3WsY3ftlQdspurkk4UsQmYht0s&_nc_ohc=BB7P9RFOlOoAX-C7wpH&_nc_ht=scontent.fkhi11-1.fna&oh=16036efe01117bde6d15b49e4d310df3&oe=61530664'),
              )),
        ),
        Text(
          userData['name'],
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25),
        )
      ],
    );
  }
}

class ProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _listTileForProfileDetail('Personal', "Account", () {}),
        _listTileForProfileDetail('Application', "About", () {}),
        _listTileForProfileDetail('protection', "Privacy", () {}),
        _listTileForProfileDetail('condition', "Term and Condition", () {}),
      ],
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

Widget _listTileForProfileDetail(
    String title, String subtitle, Function function) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      subtitle,
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
