import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_ambw/dataclass.dart';
import 'package:project_ambw/dataclass2.dart';
import 'package:project_ambw/dbservices.dart';
import 'package:project_ambw/home.dart';

import 'dbservices2.dart';
import 'notification_widget.dart';

class TaskDetails extends StatefulWidget {
  // const TaskDetails({Key? key}) : super(key: key);
  final itemTask task;
  // final String dueDate;
  const TaskDetails({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  List<String> listItem = [
    "Add New Category",
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5"
  ];

  bool isVisible = false;
  String? valueChoose = null;
  bool newCategory = false;
  //late DateTime dateTime;
  DateTime dateTime = DateTime.now();
  late TextEditingController _tfTitle;
  late TextEditingController _tfNewCategory;
  late TextEditingController _tfDetail;

  // late int dateChoose = dateTime.microsecondsSinceEpoch;

  @override
  void initState() {
    super.initState();

    dateTime = widget.task.itemTime.toDate();

    _tfTitle = TextEditingController(text: widget.task.itemTitle);
    _tfNewCategory = TextEditingController();
    _tfDetail = TextEditingController(text: widget.task.itemDetail);
    //setState() {
    if (widget.task.itemCategory != "") {
      valueChoose = widget.task.itemCategory;
    }
    //}

    Future.delayed(const Duration(seconds: 2), () {
      returnDateTime();
    });
  }

  @override
  void dispose() {
    _tfTitle.dispose();
    _tfNewCategory.dispose();
    _tfDetail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    print('valuechoose di Build: $valueChoose');
    return MaterialApp(
        title: "Task Details",
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            body: Container(
                color: Color(0xffFF171516),
                // padding: EdgeInsets.all(20),
                child: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(23, 21, 22, 1),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel",
                                      style: TextStyle(fontSize: 18))),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(23, 21, 22, 1),
                                    alignment: Alignment.centerRight,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      //print(valueChoose);

                                      if (valueChoose != null) {
                                        String selectedCategory = valueChoose!;
                                        if (valueChoose == "Add New Category") {
                                          selectedCategory =
                                              _tfNewCategory.text;

                                          Database2.tambahData(
                                              category: selectedCategory);
                                        }
                                        if (widget.task.itemId == "") {
                                          // add task

                                          final dtBaru = itemTask(
                                              itemId: "1",
                                              itemTitle: _tfTitle.text,
                                              itemDetail: _tfDetail.text,
                                              itemCategory: selectedCategory,
                                              itemDone: false,
                                              itemTime:
                                                  Timestamp.fromDate(dateTime));
                                          Database.tambahData(item: dtBaru);
                                        } else {
                                          print('Value baru: $valueChoose');
                                          final dtBaru = itemTask(
                                              itemId: widget.task.itemId,
                                              itemTitle: _tfTitle.text,
                                              itemDetail: _tfDetail.text,
                                              itemCategory: selectedCategory,
                                              itemDone: widget.task.itemDone,
                                              itemTime:
                                                  Timestamp.fromDate(dateTime));
                                          Database.ubahData(item: dtBaru);
                                        }

                                        if (DateTime.now().compareTo(dateTime) >
                                            1) {
                                          NotificationWidget
                                              .showScheduleNotification(
                                                  title: _tfTitle.text,
                                                  body: _tfDetail.text,
                                                  scheduleTime:
                                                      dateTime.subtract(
                                                          Duration(days: 1)));
                                        }

                                        Navigator.pop(context);
                                      }
                                    });
                                    // if (newCategory) {
                                    //   valueChoose = _tfNewCategory.text;
                                    // }

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => Home()));
                                    // Navigator.of(context).pushReplacement(
                                    //     new MaterialPageRoute(
                                    //         builder: (BuildContext context) =>
                                    //             Home()));
                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Color(0xffFFC3B1E1),
                                        fontSize: 18),
                                  )),
                            ),
                          ]),
                      Divider(
                        color: Color(0xffFFECECEC),
                        height: 1,
                      ),
                      //textfield Judul Tugas
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            TextField(
                              controller: _tfTitle,
                              style: TextStyle(color: Colors.white),
                              textCapitalization: TextCapitalization.words,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffFF2F2B2D))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffFF2F2B2D))),
                                  hintText: "Title",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                            SizedBox(height: 20),
                            // dropdown pilih kategori
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xffFF2F2B2D), width: 1)),
                              child: Column(children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("tabelCategory")
                                        .orderBy("category")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('ERROR',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16));
                                      } else if (snapshot.hasData ||
                                          snapshot.data != null) {
                                        //List<String> nya=snapshot.
                                        listItem = List<String>.generate(
                                            snapshot.data!.docs.length,
                                            (i) => snapshot.data!.docs[i]
                                                ['category']);
                                        listItem.add('Add New Category');

                                        //print(listItem);
                                        return DropdownButtonFormField<String>(
                                          hint: Text(
                                            "Select Category",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          dropdownColor: Color(0xffFF2F2B2D),
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          isExpanded: true,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                          value: valueChoose,
                                          onChanged: (newValue) {
                                            setState(() {
                                              print('masuik');
                                              print('newVal: $newValue');

                                              valueChoose = newValue!;
                                              print('vacho: $valueChoose');
                                              newCategory = false;
                                            });
                                            if (valueChoose ==
                                                "Add New Category") {
                                              setState(() {
                                                isVisible = true;
                                                newCategory = true;
                                              });
                                            } else {
                                              setState(() {
                                                isVisible = false;
                                              });
                                            }
                                          },
                                          items: listItem.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        );
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.pinkAccent,
                                          ),
                                        ),
                                      );
                                    }),
                                Visibility(
                                    visible: isVisible,
                                    child: TextField(
                                      controller: _tfNewCategory,
                                      style: TextStyle(color: Colors.white),
                                      textCapitalization:
                                          TextCapitalization.words,
                                      textDirection: TextDirection.ltr,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xffFF2F2B2D))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xffFF2F2B2D))),
                                          hintText: "New Category",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ))
                              ]),
                            ),

                            SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 55,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xffFFC3B1E1)),
                                    child: Text(
                                      'Due Date',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: SizedBox(
                                  height: 55,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        pickDateTime();
                                        // setState(() {
                                        //   dateChoose =
                                        //       dateTime.millisecondsSinceEpoch;
                                        // });
                                      },
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Color(0xffFF171516),
                                          side: BorderSide(
                                              color: Color(0xffFF2F2B2D),
                                              width: 1)),
                                      child: Text(
                                        '${dateTime.year}/${dateTime.month}/${dateTime.day}    $hours:$minutes',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      )),
                                ))
                              ],
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: TextField(
                                controller: _tfDetail,
                                maxLines: null,
                                expands: true,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 160, 158, 158)),
                                textCapitalization: TextCapitalization.words,
                                textDirection: TextDirection.ltr,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffFF2F2B2D))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffFF2F2B2D))),
                                    hintText: "Content",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ])))));
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return; //pressed cancel

    TimeOfDay? time = await pickTime();
    if (time == null) return; //pressed cancel

    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    setState(() => this.dateTime = dateTime);

    print(dateTime);
  }

  Future<DateTime?> pickDate() {
    return showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
  }

  Future<TimeOfDay?> pickTime() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
  }

  void returnDateTime() {
    setState(() {
      //dateTime = widget.task.itemTime.toDate();
      //valueChoose = widget.task.itemCategory.toString();
    });
  }
}
