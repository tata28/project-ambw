import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TestDropdown extends StatefulWidget {
  const TestDropdown({Key? key}) : super(key: key);

  @override
  State<TestDropdown> createState() => _TestDropdownState();
}

class _TestDropdownState extends State<TestDropdown> {
  List<String> listItem = [
    "Add New Category",
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5"
  ];

  final List<String> list = [];

  bool isVisible = false;
  String valueChoose = "Add New Category";
  bool newCategory = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "coba dropdown",
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
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
                      //List<String> nya=snapshot.
                      listItem = List<String>.generate(
                          snapshot.data!.docs.length,
                          (i) => snapshot.data!.docs[i]['category']);
                      listItem.add('Add New Category');
                      print(listItem);
                      return DropdownButton<String>(
                        hint: Text(
                          "Select Category",
                          style: TextStyle(color: Colors.grey),
                        ),
                        dropdownColor: Color(0xffFF2F2B2D),
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        isExpanded: true,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        value: valueChoose,
                        onChanged: (newValue) {
                          setState(() {
                            valueChoose = (newValue as String?)!;
                            newCategory = false;
                          });
                          if (valueChoose == "Add New Category") {
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
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.pinkAccent,
                        ),
                      ),
                    );
                  }),
            ),
            Visibility(
                visible: isVisible,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  textCapitalization: TextCapitalization.words,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffFF2F2B2D))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffFF2F2B2D))),
                      hintText: "New Category",
                      hintStyle: TextStyle(color: Colors.grey)),
                ))
          ],
        )),
      ),
    );
  }
}
