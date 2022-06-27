import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ambw/dataclass.dart';
import 'package:project_ambw/to_do_list.dart';
import 'dbservices.dart';
import 'firebase_options.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:intl/date_symbol_data_local.dart';
import 'package:project_ambw/completed.dart';
import 'package:project_ambw/settings.dart';
import 'package:project_ambw/home.dart';
import 'package:project_ambw/settings.dart';
import 'focus_session.dart';
import 'task_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(title: "My Task", home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final screens = [
    Home(),
    FocusSession(
      sessionDuration: "",
      sessionRepitition: "",
      breakDuration: "",
      musicURL: "",
      musicName: "Choose Music",
    ),
    ToDoList(),
    Completed(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Menu",
      home: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Color.fromRGBO(192, 191, 191, 0.69),
            // unselectedItemColor: Color(0xffFFC0BFBF),
            backgroundColor: Colors.black,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/img/home.png")),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/img/focus_session.png"),
                ),
                label: 'Focus Session',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/img/to_do_list.png"),
                ),
                label: 'To Do List',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/img/completed.png")),
                label: 'Completed',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/img/settings.png")),
                label: 'Settings',
                backgroundColor: Colors.transparent,
              ),
            ]),
      ),
    );
  }
}
