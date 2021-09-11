import 'package:app_tracker/ui_pages/get_permission_screen.dart';
import 'package:app_tracker/ui_pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel("getUsageDataChannel");

  Future<bool> checkForUsagePermissions() async {
    return await platform.invokeMethod('CheckPermission');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Time Tracker",
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: FutureBuilder<bool>(
          future: checkForUsagePermissions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator(color: Colors.black);
            if (snapshot.data!) return Home();
            return GetPermissionScreen();
          },
        ),
      ),
    );
  }
}
