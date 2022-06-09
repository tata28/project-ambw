import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'dataclass.dart';
import 'dbservices.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Widget> _getChildren(int count, QuerySnapshot<Object?> document) {
    return List<Widget>.generate(
      count,
      (i) => ListTile(
          title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Checkbox(
                      checkColor: Color.fromRGBO(47, 43, 45, 1),
                      fillColor: MaterialStateProperty.all(
                          Color.fromRGBO(139, 211, 206, 1)),
                      value: document.docs[i]['done'],
                      shape: CircleBorder(),
                      onChanged: (bool? value) {
                        //setState(() {
                        itemTask updateDone = itemTask(
                            itemId: document.docs[i]['id'],
                            itemTitle: document.docs[i]['title'],
                            itemDetail: document.docs[i]['detail'],
                            itemCategory: document.docs[i]['category'],
                            itemDone: value!,
                            itemTime: document.docs[i]['time']);
                        Database.ubahData(item: updateDone);
                        //});
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(document.docs[i]['title'],
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(document.docs[i]['time'].toDate())
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                                DateFormat('HH:mm')
                                    .format(document.docs[i]['time'].toDate())
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: IconButton(
                      tooltip: 'Edit Task',
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_note,
                        color: Color.fromRGBO(139, 211, 206, 1),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Delete Task',
                    onPressed: () {
                      Database.hapusData(idTask: document.docs[i]['id']);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromRGBO(139, 211, 206, 1),
                    ),
                  )
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Color.fromRGBO(139, 211, 206, 1),
          ),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(23, 21, 22, 1),
        padding: EdgeInsets.all(15),
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.checklist,
                  color: Color.fromRGBO(139, 211, 206, 1),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "To Do List",
                    style: TextStyle(
                        color: Color.fromRGBO(139, 211, 206, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: Color.fromRGBO(139, 211, 206, 1),
                ),
                label: Text(
                  "Add new task",
                  style: TextStyle(
                      color: Color.fromRGBO(139, 211, 206, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style: ButtonStyle(
                  alignment: Alignment.centerLeft,
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(47, 43, 45, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(
                              color: Color.fromRGBO(47, 43, 45, 1)))),
                  padding:
                      MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (Set<MaterialState> states) {
                      return EdgeInsets.all(20);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Column(
                  children: [
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
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
                        } else if (snapshot.hasData || snapshot.data != null) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(47, 43, 45, 1),
                                        border: Border.all(
                                          color: Color.fromRGBO(47, 43, 45, 1),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("tabelTask")
                                            .where("category",
                                                isEqualTo: snapshot.data!
                                                    .docs[index]['category'])
                                            .where("done", isEqualTo: false)
                                            .orderBy("time")
                                            .snapshots(),
                                        builder: (context, snapshot2) {
                                          if (snapshot2.hasError) {
                                            return Text('ERROR',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16));
                                          } else if (snapshot2.hasData ||
                                              snapshot2.data != null) {
                                            return ExpansionTile(
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              // sets the color of the arrow when collapsed
                                              collapsedIconColor:
                                                  Color.fromRGBO(
                                                      139, 211, 206, 1),
                                              // sets the color of the arrow when expanded
                                              iconColor: Color.fromRGBO(
                                                  139, 211, 206, 1),
                                              title: Text(
                                                  snapshot.data!.docs[index]
                                                      ['category'],
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          139, 211, 206, 1),
                                                      fontSize: 15)),
                                              children:
                                                  // [Text('a')],
                                                  _getChildren(
                                                      snapshot2
                                                          .data!.docs.length,
                                                      snapshot2.data!),
                                            );
                                          }
                                          return Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: Center(
                                              child: LoadingAnimationWidget
                                                  .staggeredDotsWave(
                                                color: Color.fromRGBO(
                                                    139, 211, 206, 1),
                                                size: 20,
                                              ),
                                            ),
                                          );
                                        }));
                              });
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(139, 211, 206, 1),
                            ),
                          ),
                        );
                      },
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
        ),
      ),
    );
  }
}
