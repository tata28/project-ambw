import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ambw/dataclass.dart';
import 'dbservices.dart';
import 'firebase_options.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:intl/date_symbol_data_local.dart';

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
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
                          Color.fromRGBO(228, 107, 103, 0.91)),
                      value: document.docs[i]['done'],
                      shape: CircleBorder(),
                      onChanged: (bool? value) {
                        setState(() {
                          itemTask updateDone = itemTask(
                              itemId: document.docs[i]['id'],
                              itemTitle: document.docs[i]['title'],
                              itemDetail: document.docs[i]['detail'],
                              itemCategory: document.docs[i]['category'],
                              itemDone: value!,
                              itemTime: document.docs[i]['time']);
                          Database.ubahData(item: updateDone);
                        });
                      },
                    ),
                  ),
                  Text(document.docs[i]['title'],
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: IconButton(
                      tooltip: 'View Task',
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                        color: Color.fromRGBO(228, 107, 103, 0.91),
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
                      color: Color.fromRGBO(228, 107, 103, 0.91),
                    ),
                  )
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Color.fromRGBO(228, 107, 103, 0.91),
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
                  Icons.check_circle,
                  color: Color.fromRGBO(228, 107, 103, 0.91),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Completed",
                    style: TextStyle(
                        color: Color.fromRGBO(228, 107, 103, 0.91),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                )
              ],
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
                          return Text('ERROR');
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
                                            .where("done", isEqualTo: true)
                                            .orderBy("time")
                                            .snapshots(),
                                        builder: (context, snapshot2) {
                                          if (snapshot2.hasError) {
                                            return Text('ERROR');
                                          } else if (snapshot2.hasData ||
                                              snapshot2.data != null) {
                                            return ExpansionTile(
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              // sets the color of the arrow when collapsed
                                              collapsedIconColor:
                                                  Color.fromRGBO(
                                                      228, 107, 103, 0.91),
                                              // sets the color of the arrow when expanded
                                              iconColor: Color.fromRGBO(
                                                  228, 107, 103, 0.91),
                                              title: Text(
                                                  snapshot.data!
                                                      .docs[index]['category'],
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          228, 107, 103, 0.91),
                                                      fontSize: 15)),
                                              children: _getChildren(
                                                  snapshot2.data!.docs.length,
                                                  snapshot2.data!),
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
                                        }));
                              });
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.pinkAccent,
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
    ;
  }
}
