import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ambw/dbservices.dart';
import 'package:project_ambw/in_session_page.dart';
import 'package:project_ambw/music_list.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:intl/date_symbol_data_local.dart';
import 'package:project_ambw/dataclass.dart';
import 'package:project_ambw/settings.dart' as pSettings;
import 'package:project_ambw/task_details.dart';
import 'package:project_ambw/to_do_list.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _tfUsername = TextEditingController();
  TextEditingController _tfPassword = TextEditingController();

  @override
  void dispose() {
    _tfPassword.dispose();
    _tfUsername.dispose();
    super.dispose();
  }

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
                      ImageIcon(AssetImage("assets/img/settings.png"),
                          color: Color.fromRGBO(159, 215, 227, 0.91), size: 17),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "Login",
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
                            TextField(
                              controller: _tfUsername,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 160, 158, 158)),
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffFF2F2B2D))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffFF2F2B2D))),
                                  labelText: "Username",
                                  labelStyle:
                                      TextStyle(color: Color(0xffFFF5B6C2))),
                            ),
                            TextField(
                              controller: _tfPassword,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 160, 158, 158)),
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffFF2F2B2D))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffFF2F2B2D))),
                                  labelText: "Password",
                                  labelStyle:
                                      TextStyle(color: Color(0xffFFF5B6C2))),
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: Text("Login"))
                          ],
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
