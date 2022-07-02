import 'dart:js';

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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _nextTaskName = "", _nextTaskTime = "", _nextSchedule = "";
  DateTime _start = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
  DateTime _end = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 23, 59, 59);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("tabelTask")
              .where('time', isGreaterThanOrEqualTo: _start)
              .where('time', isLessThanOrEqualTo: _end)
              .orderBy("time")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color.fromRGBO(23, 21, 22, 1),
                  padding: EdgeInsets.all(15),
                  child: Text('ERROR',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)));
            } else if (snapshot.hasData || snapshot.data != null) {
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("tabelTask")
                      .where('time', isGreaterThanOrEqualTo: DateTime.now())
                      .where('time', isLessThanOrEqualTo: _end)
                      .orderBy('time')
                      .snapshots(),
                  builder: ((context, snapshot2) {
                    if (snapshot2.hasError) {
                      print('error');
                      return Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Color.fromRGBO(23, 21, 22, 1),
                          padding: EdgeInsets.all(15),
                          child: Center(
                            child: Text('ERROR',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                          ));
                    } else if (snapshot2.hasData || snapshot2.data != null) {
                      if (snapshot2.data!.docs.length == 0) {
                        _nextSchedule = "No more task for today";
                        _nextTaskName = "";
                        _nextTaskTime = "";
                      } else {
                        List<itemTask> todayTask = List<itemTask>.generate(
                            snapshot2.data!.docs.length,
                            (i) => itemTask(
                                itemCategory: snapshot2.data!.docs[i]
                                    ['category'],
                                itemDetail: snapshot2.data!.docs[i]['detail'],
                                itemDone: snapshot2.data!.docs[i]['done'],
                                itemTime: snapshot2.data!.docs[i]['time'],
                                itemTitle: snapshot2.data!.docs[i]['title'],
                                itemId: snapshot2.data!.docs[i]['id']));

                        _nextSchedule = "No more task for today";
                        _nextTaskName = "";
                        _nextTaskTime = "";
                        for (var i = 0; i < todayTask.length; i++) {
                          var task = todayTask[i];
                          if (task.itemDone == false) {
                            _nextSchedule = "NEXT ON SCHEDULE";
                            _nextTaskName = task.itemTitle;
                            _nextTaskTime = DateFormat('H:mm')
                                .format(task.itemTime.toDate())
                                .toString();
                            break;
                          }
                        }
                      }
                      return Container(
                        color: Color.fromRGBO(23, 21, 22, 1),
                        padding: EdgeInsets.all(15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ImageIcon(
                                          AssetImage("assets/img/home.png"),
                                          color:
                                              Color.fromRGBO(111, 128, 200, 1),
                                          size: 17),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "My Day",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  111, 128, 200, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      // coba tambah data
                                      // itemTask newItem = itemTask(
                                      //     itemId: "id baru",
                                      //     itemTitle: "Tugas Baru",
                                      //     itemDetail: "test",
                                      //     itemCategory: "Sekolah",
                                      //     itemDone: false,
                                      //     itemTime: Timestamp.fromDate(
                                      //         DateTime.now().add(
                                      //             const Duration(hours: 2))));
                                      // Database.tambahData(item: newItem);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TaskDetails(
                                                  title: "",
                                                  category: "",
                                                  dueDate: Timestamp.now(),
                                                  details: "")));
                                    },
                                    child: Text("+ Add New Task",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                192, 191, 191, 1))),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          width: 1.0,
                                          color:
                                              Color.fromRGBO(192, 191, 191, 1)),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                                  width: double.infinity,
                                  height: 122,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(72, 63, 132, 1),
                                    border: Border.all(
                                      color: Color.fromRGBO(72, 63, 132, 1),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    // image: DecorationImage(
                                    //   image: AssetImage("assets/home_banner.png"),
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                  child: Stack(children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      right: -25,
                                      child: (Image(
                                        image: AssetImage(
                                            "assets/home_banner_art.png"),
                                        width: 150,
                                      )),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(13),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 18),
                                              child: Text(
                                                DateFormat('EEEE, d MMMM yyyy')
                                                    .format(DateTime.now())
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              _nextSchedule,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                            Text(_nextTaskTime,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15)),
                                            Text(_nextTaskName,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12)),
                                          ]),
                                    ),
                                  ])),
                              Container(
                                margin: EdgeInsets.only(bottom: 3),
                                child: Text(
                                  "Today's Tasks",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 3, 0, 3),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(47, 43, 45, 1),
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    47, 43, 45, 1),
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 15),
                                                        child: Checkbox(
                                                          checkColor:
                                                              Color.fromRGBO(47,
                                                                  43, 45, 1),
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .all(Color
                                                                      .fromRGBO(
                                                                          111,
                                                                          128,
                                                                          200,
                                                                          1)),
                                                          value: snapshot.data!
                                                                  .docs[index]
                                                              ['done'],
                                                          shape: CircleBorder(),
                                                          onChanged:
                                                              (bool? value) {
                                                            //setState(() {
                                                            itemTask updateDone = itemTask(
                                                                itemId: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['id'],
                                                                itemTitle: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['title'],
                                                                itemDetail: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['detail'],
                                                                itemCategory: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    [
                                                                    'category'],
                                                                itemDone: value!,
                                                                itemTime: snapshot.data!.docs[index]['time']);
                                                            Database.ubahData(
                                                                item:
                                                                    updateDone);
                                                            //});
                                                          },
                                                        )),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['title'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12)),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 3),
                                                          child: Text(
                                                              DateFormat('H:mm')
                                                                  .format(snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'time']
                                                                      .toDate())
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      13)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 0),
                                                      child: IconButton(
                                                        tooltip: 'Edit Task',
                                                        onPressed: () {},
                                                        icon: ImageIcon(
                                                          AssetImage(
                                                              "assets/img/edit.png"),
                                                          color: Color.fromRGBO(
                                                              111, 128, 200, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      tooltip: 'Delete Task',
                                                      onPressed: () {
                                                        Database.hapusData(
                                                            idTask: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['id']);
                                                      },
                                                      icon: ImageIcon(
                                                        AssetImage(
                                                            "assets/img/delete.png"),
                                                        color: Color.fromRGBO(
                                                            111, 128, 200, 1),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ]));
                                    }),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //               builder: (context) =>
                                  //                   MusicList()));
                                  //     },
                                  //     child: Text("MusicList")),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ToDoList()));
                                      },
                                      child: Text("ToDoList")),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InSessionPage(
                                                      sessionDuration: "1.5",
                                                      sessionRepitition: "3",
                                                      breakDuration: "0.5",
                                                      musicURL:
                                                          "https://firebasestorage.googleapis.com/v0/b/my-task-9254e.appspot.com/o/musics%2FCalum%20Scott%20-%20You%20Are%20The%20Reason%20(Official).mp3?alt=media&token=675eacea-c01a-45a5-b3a2-2de2009ed50d",
                                                    )));
                                      },
                                      child: Text("In Session Page"))
                                ],
                              )
                            ]),
                      );
                    }
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Color.fromRGBO(23, 21, 22, 1),
                        padding: EdgeInsets.all(15),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(111, 128, 200, 1),
                            ),
                          ),
                        ));
                  }));
            }
            return Container(
                color: Color.fromRGBO(23, 21, 22, 1),
                padding: EdgeInsets.all(15),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(111, 128, 200, 1),
                    ),
                  ),
                ));
          }),
    );
  }
}
