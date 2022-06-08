import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ambw/dataclass.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'dbservices.dart';
import 'firebase_options.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:project_ambw/completed.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool blockNotif = false, silentMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromRGBO(23, 21, 22, 1),
            padding: EdgeInsets.all(15),
            child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Icon(
                        Icons.settings,
                        color: Color.fromRGBO(159, 215, 227, 0.91),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "Settings",
                          style: TextStyle(
                              color: Color.fromRGBO(159, 215, 227, 0.91),
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      )
                    ]),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Column(
                          children: [
                            Expanded(
                                child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(47, 43, 45, 1),
                                      border: Border.all(
                                        color: Color.fromRGBO(47, 43, 45, 1),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Block Notification",
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                        Switch(
                                          value: blockNotif,
                                          onChanged: (value) async {
                                            bool? isGranted =
                                                await PermissionHandler
                                                    .permissionsGranted;
                                            if (blockNotif == false) {
                                              if (isGranted!) {
                                                await FlutterDnd
                                                    .setInterruptionFilter(
                                                        FlutterDnd
                                                            .INTERRUPTION_FILTER_NONE);
                                                setState(() {
                                                  blockNotif = value;
                                                }); // Turn on DND
                                              } else {
                                                FlutterDnd.gotoPolicySettings();
                                              }
                                            } else {
                                              if (isGranted!) {
                                                await FlutterDnd
                                                    .setInterruptionFilter(
                                                        FlutterDnd
                                                            .INTERRUPTION_FILTER_ALL);
                                                setState(() {
                                                  blockNotif = value;
                                                }); // Turn off DND
                                              } else {
                                                FlutterDnd.gotoPolicySettings();
                                              }
                                            }
                                          },
                                          inactiveTrackColor: Colors.grey,
                                          activeTrackColor: Color.fromRGBO(
                                              159, 215, 227, 0.4),
                                          activeColor:
                                              Color.fromRGBO(159, 215, 227, 1),
                                        )
                                      ]),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(47, 43, 45, 1),
                                      border: Border.all(
                                        color: Color.fromRGBO(47, 43, 45, 1),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Silent Mode",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Switch(
                                          value: silentMode,
                                          onChanged: (value) async {
                                            //setState(() {
                                            bool? isGranted =
                                                await PermissionHandler
                                                    .permissionsGranted;
                                            if (silentMode == false) {
                                              if (!isGranted!) {
                                                await PermissionHandler
                                                    .openDoNotDisturbSetting();
                                              } else {
                                                await SoundMode.setSoundMode(
                                                    RingerModeStatus.silent);
                                                setState(() {
                                                  silentMode = value;
                                                });
                                              }
                                            } else {
                                              if (!isGranted!) {
                                                await PermissionHandler
                                                    .openDoNotDisturbSetting();
                                              } else {
                                                await SoundMode.setSoundMode(
                                                    RingerModeStatus.normal);
                                                setState(() {
                                                  silentMode = value;
                                                });
                                              }
                                            }
                                            //});
                                          },
                                          inactiveTrackColor: Colors.grey,
                                          activeTrackColor: Color.fromRGBO(
                                              159, 215, 227, 0.4),
                                          activeColor:
                                              Color.fromRGBO(159, 215, 227, 1),
                                        )
                                      ]),
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Home"))
                      ],
                    )
                  ]),
            )));
  }
}
