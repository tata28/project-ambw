import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_ambw/storage_service.dart';

import 'in_session_page.dart';

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

  // late Future<ListResult> futureMusics;

  // @override
  // void initState() {
  //   futureMusics = FirebaseStorage.instance.ref('/musics').listAll();

  //   super.initState();
  // }

  // final Storage storage = Storage();

  late Future<ListResult> futureFiles;
  String link = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/musics').listAll();
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
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: () {
                              print(link);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InSessionPage(
                                            sessionDuration: "1.5",
                                            sessionRepitition: "3",
                                            breakDuration: "0.5",
                                            musicURL: link,
                                          )));
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Color.fromRGBO(245, 182, 194, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
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
                                      child: FutureBuilder<ListResult>(
                                        future: futureFiles,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final files = snapshot.data!.items;
                                            return ListView.builder(
                                              itemCount: files.length,
                                              itemBuilder: (context, index) {
                                                final file = files[index];
                                                return Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 3, 0, 3),
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            47, 43, 45, 1),
                                                        border: Border.all(
                                                          color: Color.fromRGBO(
                                                              47, 43, 45, 1),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        link = (await file
                                                            .getDownloadURL());
                                                      },
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                file.name,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          0.83),
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: false,
                                                              ),
                                                            ),
                                                          ]),
                                                    ));
                                              },
                                            );
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  snapshot.error.toString(),
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.83),
                                                  )),
                                            );
                                          } else {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color.fromRGBO(
                                                      245, 182, 194, 1),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      //     FutureBuilder(
                                      //   future: storage.listFiles(),
                                      //   builder: (BuildContext context,
                                      //       AsyncSnapshot<
                                      //               firebase_storage.ListResult>
                                      //           snapshot) {
                                      //     if (snapshot.connectionState ==
                                      //             ConnectionState.done &&
                                      //         snapshot.hasData) {
                                      //       return Container(
                                      //         child: ListView.builder(
                                      //           itemCount:
                                      //               snapshot.data!.items.length,
                                      //           itemBuilder:
                                      //               (BuildContext context,
                                      //                   int index) {
                                      //             return ListTile(
                                      //               title: Text(snapshot
                                      //                   .data!.items[index].name),
                                      //             );
                                      //           },
                                      //         ),
                                      //       );
                                      //     } else if (snapshot.connectionState ==
                                      //         ConnectionState.waiting) {
                                      //       return const Center(
                                      //         child: CircularProgressIndicator(
                                      //           valueColor:
                                      //               AlwaysStoppedAnimation<Color>(
                                      //             Color.fromRGBO(
                                      //                 245, 182, 194, 1),
                                      //           ),
                                      //         ),
                                      //       );
                                      //     } else if (!snapshot.hasData) {
                                      //       print('error');
                                      //     }
                                      //     return Container();
                                      //   },
                                      // )
                                      // FutureBuilder<ListResult>(
                                      //   future: futureMusics,
                                      //   builder: (context, snapshot) {
                                      //     if (snapshot.hasData) {
                                      //       final files = snapshot.data!.items;

                                      //       return ListView.builder(
                                      //         itemCount: files.length,
                                      //         itemBuilder: (context, index) {
                                      //           final file = files[index];
                                      //           return ListTile(
                                      //             title: Text(file.name),
                                      //           );
                                      //         },
                                      //       );
                                      //     } else if (snapshot.hasError) {
                                      //       return const Center(
                                      //           child: Text('Error occured'));
                                      //     } else {
                                      //       return const Center(
                                      //         child: CircularProgressIndicator(
                                      //           valueColor:
                                      //               AlwaysStoppedAnimation<
                                      //                   Color>(
                                      //             Color.fromRGBO(
                                      //                 245, 182, 194, 1),
                                      //           ),
                                      //         ),
                                      //       );
                                      //     }
                                      //   },
                                      // ),
                                      // ================================
                                      // ListView.builder(
                                      //     shrinkWrap: true,
                                      //     itemCount: list_music.length,
                                      //     itemBuilder: (context, index) {
                                      //       return Container(
                                      //           margin: EdgeInsets.fromLTRB(
                                      //               0, 3, 0, 3),
                                      //           padding: EdgeInsets.all(10),
                                      //           decoration: BoxDecoration(
                                      //               color: Color.fromRGBO(
                                      //                   47, 43, 45, 1),
                                      //               border: Border.all(
                                      //                 color: Color.fromRGBO(
                                      //                     47, 43, 45, 1),
                                      //               ),
                                      //               borderRadius:
                                      //                   BorderRadius.all(
                                      //                       Radius.circular(
                                      //                           5))),
                                      //           child: Row(
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment
                                      //                       .spaceBetween,
                                      //               children: [
                                      //                 Text(list_music[index],
                                      //                     style: TextStyle(
                                      //                       color:
                                      //                           Color.fromRGBO(
                                      //                               255,
                                      //                               255,
                                      //                               255,
                                      //                               0.83),
                                      //                     )),
                                      //               ]));
                                      //     }),
                                    ),
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
