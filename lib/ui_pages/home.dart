import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const platform = MethodChannel("getUsageDataChannel");
  int days = 1;
  int selectedIndex = 0;

  showNotifications(String label, int id) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    AndroidNotificationDetails notificationAndroidSpecifics =
        AndroidNotificationDetails(
            'groupChannelId', 'groupChannelName', 'groupChannelDescription',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);

    NotificationDetails notificationPlatformSpecifics =
        NotificationDetails(android: notificationAndroidSpecifics);

    await flutterLocalNotificationsPlugin.show(
        id,
        '$label',
        'This app has been used for more than 1 hour',
        notificationPlatformSpecifics,
        payload: 'item x');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleSwitch(
                    minWidth: 150,
                    initialLabelIndex: selectedIndex,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: ['Last 24 Hours', 'Last 7 Days'],
                    activeBgColor: [Colors.blue],
                    onToggle: (index) {
                      setState(() {
                        selectedIndex = index;
                        if (index == 0) days = 1;
                        if (index == 1) days = 8;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: platform.invokeMethod('GetData', {"days": days}),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());

                  if (snapshot.data != null) {
                    List<Object?> data = snapshot.data! as List<Object?>;
                    List<String> allAppNames = [];
                    List<String> allAppTimes = [];
                    for (int i = 0; i < data.length; i++) {
                      if (i.isEven) {
                        allAppNames.add(data[i].toString());
                      } else {
                        allAppTimes.add(data[i].toString());
                      }
                    }
                    Map<String, String> appData = {};
                    for (var i = 0; i < allAppNames.length; i++) {
                      appData.putIfAbsent(allAppNames[i], () => allAppTimes[i]);
                    }

                    appData
                        .removeWhere((key, value) => int.parse(value) < 10000);

                    return ListView(
                      children: List.generate(
                        appData.length,
                        (index) {
                          String label = appData.keys.toList()[index];
                          int milliseconds =
                              int.parse(appData.values.toList()[index]);
                          if (milliseconds > 3600000)
                            showNotifications(label, index);
                          return Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                label,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                _printDuration(
                                  Duration(milliseconds: milliseconds),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return Center(
                    child: Text("No Data Found"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class TimerContainerForFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        DateTime.now().toString(),
        style: TextStyle(),
      ),
    );
  }
}
