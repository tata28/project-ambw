import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'music_list.dart';

class FocusSession extends StatefulWidget {
  const FocusSession({Key? key}) : super(key: key);

  @override
  State<FocusSession> createState() => _FocusSessionState();
}

class _FocusSessionState extends State<FocusSession> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "focus session",
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            body: Container(
                padding: EdgeInsets.all(20),
                child: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageIcon(
                                AssetImage(
                                    "assets/img/focus_session_selected.png"),
                                color: Color(0xffFFFE5ABB6),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text("Focus Session",
                                    style: TextStyle(
                                        color: Color(0xffFFF5B6C2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              )
                            ]),
                        SizedBox(height: 30),
                        Container(
                          child: Text("Sessions",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextField(
                            style: TextStyle(
                                color: Color.fromARGB(255, 160, 158, 158)),
                            textCapitalization: TextCapitalization.words,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffFF2F2B2D))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffFF2F2B2D))),
                                labelText: "Durations (minutes)",
                                labelStyle:
                                    TextStyle(color: Color(0xffFFF5B6C2))),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextField(
                            style: TextStyle(
                                color: Color.fromARGB(255, 160, 158, 158)),
                            textCapitalization: TextCapitalization.words,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffFF2F2B2D))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffFF2F2B2D))),
                                labelText: "Repetitions (times)",
                                labelStyle:
                                    TextStyle(color: Color(0xffFFF5B6C2))),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          child: Text("Breaks",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextField(
                            style: TextStyle(
                                color: Color.fromARGB(255, 160, 158, 158)),
                            textCapitalization: TextCapitalization.words,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffFF2F2B2D))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffFF2F2B2D))),
                                labelText: "Durations (minutes)",
                                labelStyle:
                                    TextStyle(color: Color(0xffFFF5B6C2))),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          child: Text("Music",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                        ),
                        SizedBox(height: 20),
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                  width: 350,
                                  height: 55,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xffFF2F2B2D)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MusicList()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Music 1'),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Color(0xffFFF5B6C2),
                                        )
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 60),
                              SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: Color(0xffFFF5B6C2),
                                            width: 1)),
                                    child: Text(
                                      'START SESSION',
                                      style: TextStyle(
                                          color: Color(0xffFFF5B6C2),
                                          fontSize: 20),
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ]),
                ))));
  }
}
