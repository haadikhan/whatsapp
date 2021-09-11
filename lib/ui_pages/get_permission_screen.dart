import 'package:app_tracker/ui_pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetPermissionScreen extends StatefulWidget {
  @override
  _GetPermissionScreenState createState() => _GetPermissionScreenState();
}

class _GetPermissionScreenState extends State<GetPermissionScreen> {
  static const platform = MethodChannel("getUsageDataChannel");
  int code = 1;

  @override
  Widget build(BuildContext context) {
    print("Is screen rebuilding");
    return Scaffold(
      body: Container(
        child: MaterialButton(
          onPressed: () async {
            bool isPermissionGranted =
                await platform.invokeMethod("CheckPermission");
            if (isPermissionGranted) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            } else {
              await platform.invokeMethod("GetPermission");
            }
          },
          child: Text("Get Permission"),
        ),
      ),
    );
  }
}
