import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ambw/dataclass3.dart';
import 'package:project_ambw/dbservices.dart';
import 'package:project_ambw/in_session_page.dart';
import 'package:project_ambw/music_list.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:intl/date_symbol_data_local.dart';
import 'package:project_ambw/dataclass.dart';
import 'package:project_ambw/settings.dart' as pSettings;
import 'package:project_ambw/task_details.dart';
import 'package:project_ambw/to_do_list.dart';

import 'dbservices3.dart';
import 'home.dart';

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
                      Icon(Icons.login,
                          color: Color.fromRGBO(159, 215, 227, 0.91), size: 17),
                      // color: Color.fromRGBO(159, 215, 227, 0.91), size: 17) ImageIcon(AssetImage("assets/img/settings.png"),,
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
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("tabelUser")
                                    //     .where("username",
                                    //         isEqualTo: _tfUsername.text.toString())
                                    // .where("password",
                                    //     isEqualTo: _tfPassword.text.toString())
                                    .snapshots(),
                                // stream: FirebaseFirestore.instance
                                //     .collection("tabelCategory")
                                //     .orderBy("category")
                                //     .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('ERROR',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16));
                                  } else if (snapshot.hasData ||
                                      snapshot.data != null) {
                                    return ElevatedButton(
                                        onPressed: () {
                                          print('CEK ISI SNAPSHOT');
                                          print('panjang data');
                                          print(snapshot.data?.docs.length);

                                          for (int i = 0;
                                              i < snapshot.data!.docs.length;
                                              i++) {
                                            print(
                                                "Entry ke $i : username = ${snapshot.data!.docs[i]['username']} ");
                                          }
                                          if (snapshot.data!.docs.length > 0) {
                                            var isSuccess = false;
                                            for (int i = 0;
                                                i < snapshot.data!.docs.length;
                                                i++) {
                                              if (_tfUsername.text.toString() ==
                                                      snapshot.data!.docs[i]
                                                          ['username'] &&
                                                  _tfPassword.text.toString() ==
                                                      snapshot.data!.docs[i]
                                                          ['password']) {
                                                isSuccess = true;
                                              }
                                            }
                                            if (isSuccess) {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (((context) =>
                                              //             Home()))));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Username/password salah!'),
                                              ));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text('Tidak ada data'),
                                            ));
                                            setState(() {
                                              _tfPassword.clear();
                                              _tfUsername.clear();
                                            });
                                          }
                                          print('isi tf password : ' +
                                              _tfPassword.text);
                                          print('isi tf username : ' +
                                              _tfUsername.text);
                                        },
                                        child: Text("Login"));
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.pinkAccent,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                            SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () {
                                  final dtUser = itemUser(
                                      itemUsername: _tfUsername.text,
                                      itemPassword: _tfPassword.text);
                                  Database3.tambahData(item: dtUser);

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Berhasil sign up!'),
                                  ));
                                  setState(() {
                                    _tfPassword.clear();
                                    _tfUsername.clear();
                                  });
                                },
                                child: Text("Sign Up"))
                          ],
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
