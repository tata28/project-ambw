import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project_ambw/notification_widget.dart';
import 'package:timezone/data/latest.dart' as tz;

class TesNotif extends StatefulWidget {
  const TesNotif({Key? key}) : super(key: key);

  @override
  State<TesNotif> createState() => _TesNotifState();
}

class _TesNotifState extends State<TesNotif> {
  @override
  void initState() {
    super.initState();
    NotificationWidget.init();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "tes notif",
        home: Scaffold(
          appBar: AppBar(),
          body: Container(
              child: Center(
            child: Column(children: [
              ElevatedButton(
                child: Text("notif biasa"),
                onPressed: () {
                  NotificationWidget.showNotification(
                      title: "Coba notifikasi", body: "Notifikasi biasa");
                },
              ),
              ElevatedButton(
                child: Text("notif scheduled"),
                onPressed: () {
                  NotificationWidget.showScheduleNotification(
                      title: "Coba notifikasi",
                      body: "Scheduled Notification",
                      scheduleTime: DateTime.now().add(Duration(seconds: 5)));
                },
              ),
            ]),
          )),
        ));
  }
}
