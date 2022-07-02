import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_ambw/dataclass.dart';
import 'package:project_ambw/dataclass2.dart';
import 'package:project_ambw/dbservices.dart';
import 'package:project_ambw/home.dart';

import 'dbservices2.dart';

class TaskDetails extends StatefulWidget {
  // const TaskDetails({Key? key}) : super(key: key);
  final String title, category, details;
  final Timestamp dueDate;
  // final String dueDate;
  const TaskDetails(
      {Key? key,
      required this.title,
      required this.category,
      required this.dueDate,
      required this.details})
      : super(key: key);

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

  bool isVisible = true;
  String valueChoose = "Add New Category";
  bool newCategory = false;
  DateTime dateTime = DateTime.now();
  // late int dateChoose = dateTime.microsecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    TextEditingController _tfTitle = TextEditingController(text: widget.title);
    TextEditingController _tfNewCategory = TextEditingController();
    TextEditingController _tfDetail =
        TextEditingController(text: widget.details);

    @override
    void dispose() {
      _tfTitle.dispose();
      _tfNewCategory.dispose();
      _tfDetail.dispose();
      super.dispose();
    }

    @override
    void initState() {
      super.initState();

      Future.delayed(const Duration(seconds: 2), () {
        returnDateTime();
      });
    }

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
                                    setState(() {});
                                    if (newCategory) {
                                      valueChoose = _tfNewCategory.text;
                                    }

                                    final dtBaru = itemTask(
                                        itemId: "1",
                                        itemTitle: _tfTitle.text,
                                        itemDetail: _tfDetail.text,
                                        itemCategory: valueChoose,
                                        itemDone: false,
                                        itemTime: Timestamp.fromDate(dateTime));
                                    Database.tambahData(item: dtBaru);
                                    final dtBaru2 = itemCategory(
                                        itemId: "1", category: valueChoose);
                                    if (newCategory) {
                                      Database2.tambahData(item: dtBaru2);
                                    }

                                    // Navigator.pop(context);
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
                                        return DropdownButton<String>(
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
                                              valueChoose =
                                                  (newValue as String?)!;
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

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

  void returnDateTime() {
    setState(() {
      dateTime = widget.dueDate.toDate();
      valueChoose = widget.category.toString();
    });
  }
}
