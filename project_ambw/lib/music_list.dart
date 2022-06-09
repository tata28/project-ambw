import 'package:flutter/material.dart';

class MusicList extends StatefulWidget {
  const MusicList({Key? key}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  List<String> list_music = [
    'Music 1',
    'Music 2',
    'Music 3',
    'Music 4',
    'Music 5',
    'Music 6',
    'Music 7',
    'Music 8',
    'Music 9',
    'Music 10',
    'Music 11',
    'Music 12',
    'Music 13',
    'Music 14',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromRGBO(23, 21, 22, 1),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Color.fromRGBO(245, 182, 194, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(236, 236, 236, 0.5)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Divider(color: Color.fromRGBO(20, 18, 19, 1)),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Icon(
                                  //   Icons.settings,
                                  //   color: Color.fromRGBO(159, 215, 227, 0.91),
                                  // ),
                                  Container(
                                    // margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Music",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(245, 182, 194, 1),
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
                                    Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: list_music.length,
                                            itemBuilder: (context, index) {
                                              return
                                                  // Container(
                                                  //   margin:
                                                  //       EdgeInsets.only(left: 10),
                                                  //   child: Text(
                                                  //     list_music[index],
                                                  //     style: TextStyle(
                                                  //         color: Color.fromRGBO(
                                                  //             159, 215, 227, 0.91),
                                                  //         fontWeight:
                                                  //             FontWeight.bold,
                                                  //         fontSize: 17),
                                                  //   ),
                                                  // );
                                                  Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 3, 0, 3),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              47, 43, 45, 1),
                                                          border: Border.all(
                                                            color:
                                                                Color.fromRGBO(
                                                                    47,
                                                                    43,
                                                                    45,
                                                                    1),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                list_music[
                                                                    index],
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          0.83),
                                                                )),
                                                          ]));
                                            }))
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
                ],
              ),
            )));
  }
}