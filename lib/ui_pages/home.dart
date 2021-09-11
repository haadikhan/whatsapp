import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const platform = MethodChannel("getUsageDataChannel");

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
        child: FutureBuilder(
          future: platform.invokeMethod('GetData'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();

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

              appData.removeWhere((key, value) => int.tryParse(value) == 0);

              return ListView(
                children: List.generate(
                  appData.length,
                  (index) => ListTile(
                    title: Text(appData.keys.toList()[index]),
                    subtitle: Text(
                      _printDuration(
                        Duration(
                          milliseconds:
                              int.parse(appData.values.toList()[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }

            return Center(
              child: Text("No Data Found"),
            );
          },
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

class FacebookOpenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // await launch('');
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.blue,
        ),
        child: Column(
          children: [
            Text(
              'Open Facebook',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class WhatsAppOpenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.green,
        ),
        child: Column(
          children: [
            Text(
              'Open WhatsApp',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class InstagramOpenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.red[900],
        ),
        child: Column(
          children: [
            Text(
              'Open Instagram',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class TwitterOpenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.cyanAccent[400],
        ),
        child: Column(
          children: [
            Text(
              'Open Twitter',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class TimerContainerForFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(DateTime.now().toString()),
    );
  }
}
