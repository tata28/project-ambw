import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';

class InSessionPage extends StatefulWidget {
  final String sessionDuration, sessionRepitition, breakDuration;
  const InSessionPage(
      {Key? key,
      required this.sessionDuration,
      required this.sessionRepitition,
      required this.breakDuration})
      : super(key: key);

  @override
  State<InSessionPage> createState() => _InSessionPageState();
}

class _InSessionPageState extends State<InSessionPage> {
  int session_duration = 0;
  int session_repitition = 0;
  int break_duration = 0;
  int duration = 0;
  int duration_min = 0;
  int duration_sec = 0;
  String duration_text = "";
  String status = "";
  String next = "";
  Timer? timer;

  @override
  void initState() {
    session_duration = (double.parse(widget.sessionDuration) * 60) as int;
    break_duration = (double.parse(widget.breakDuration) * 60) as int;
    duration = session_duration;

    setText();
    startTimer();
    session_repitition++;
    status = "session";
    next = "${widget.breakDuration} min break";

    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (duration > 0) {
          duration--;
          setText();
        } else if (session_repitition < int.parse(widget.sessionRepitition)) {
          if (status == "session") {
            stopTimer();
            duration = break_duration;

            setText();
            startTimer();
            status = "break";
            next = "${widget.sessionDuration} min focus";
          } else {
            stopTimer();
            duration = session_duration;

            setText();
            startTimer();
            session_repitition++;
            status = "session";
            next = "${widget.breakDuration} min break";
          }
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void setText() {
    duration_min = (duration ~/ 60);
    duration_sec = duration % 60;
    if (duration_sec < 10) {
      duration_text = duration_min.toString() + ":0" + duration_sec.toString();
    } else {
      duration_text = duration_min.toString() + ":" + duration_sec.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromRGBO(23, 21, 22, 1),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    // padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              size: 30,
                            ),
                            style: ButtonStyle(
                              // alignment: Alignment.centerLeft,
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(23, 21, 22, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      side: BorderSide(
                                          color:
                                              Color.fromRGBO(23, 21, 22, 1)))),
                              padding: MaterialStateProperty.resolveWith<
                                  EdgeInsetsGeometry>(
                                (Set<MaterialState> states) {
                                  return EdgeInsets.all(15);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Focus",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "${session_repitition.toString()} of ${widget.sessionRepitition}",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.76),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(50),
                                      // width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Text(duration_text,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 60)),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Stop Music",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontSize: 13)),
                                            style: ButtonStyle(
                                              // alignment: Alignment.centerLeft,
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color.fromRGBO(
                                                          37, 37, 37, 1)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      side: BorderSide(
                                                          color: Color.fromRGBO(
                                                              37, 37, 37, 1)))),
                                              padding: MaterialStateProperty
                                                  .resolveWith<
                                                      EdgeInsetsGeometry>(
                                                (Set<MaterialState> states) {
                                                  return EdgeInsets.all(15);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  195, 177, 255, 1),
                                              width: 8),
                                          shape: BoxShape.circle),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          final isRunning = timer == null
                                              ? false
                                              : timer!.isActive;

                                          if (isRunning) {
                                            stopTimer();
                                          } else {
                                            startTimer();
                                          }
                                        },
                                        child: Icon(Icons.stop,
                                            color: Colors.black, size: 32),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(12),
                                          primary:
                                              Color.fromRGBO(195, 177, 255, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 50),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Next : ",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.78),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Container(
                                      // margin:
                                      //     EdgeInsets.only(left: 5),
                                      child: Text(
                                        next,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ]),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     ElevatedButton(
                            //         onPressed: () {
                            //           Navigator.pop(context);
                            //         },
                            //         child: Text("Home"))
                            //   ],
                            // )
                          ]),
                    ),
                  ),
                ],
              ),
            )));
  }
}
