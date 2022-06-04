import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "My Task", home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<bool> done = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(23, 21, 22, 1),
        padding: EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.home_filled,
                    color: Color.fromRGBO(111, 128, 200, 1),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "My Day",
                      style: TextStyle(
                          color: Color.fromRGBO(111, 128, 200, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text("+ Add New Task",
                    style: TextStyle(color: Color.fromRGBO(192, 191, 191, 1))),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      width: 1.0, color: Color.fromRGBO(192, 191, 191, 1)),
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
                borderRadius: BorderRadius.all(Radius.circular(5)),
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
                    image: AssetImage("assets/home_banner_art.png"),
                    width: 150,
                  )),
                ),
                Container(
                  padding: EdgeInsets.all(13),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 18),
                          child: Text(
                            "Selasa, 9 November 2021",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        Text(
                          "NEXT ON SCHEDULE",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text("11.30",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        Text("Tugas Machine Learning",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
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
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(47, 43, 45, 1),
                          border: Border.all(
                            color: Color.fromRGBO(47, 43, 45, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 15),
                                    child: Checkbox(
                                      checkColor: Color.fromRGBO(47, 43, 45, 1),
                                      fillColor: MaterialStateProperty.all(
                                          Color.fromRGBO(111, 128, 200, 1)),
                                      value: done[index],
                                      shape: CircleBorder(),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          done[index] = value!;
                                        });
                                      },
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Tugas Machine",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      child: Text("11.30",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 3),
                                  child: IconButton(
                                    tooltip: 'Edit Task',
                                    onPressed: () {},
                                    icon: Icon(Icons.edit,
                                        color:
                                            Color.fromRGBO(111, 128, 200, 1)),
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Delete Task',
                                  onPressed: () {},
                                  icon: Icon(Icons.delete,
                                      color: Color.fromRGBO(111, 128, 200, 1)),
                                )
                              ],
                            )
                          ]));
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                  child: Text("Settings")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Completed()));
                  },
                  child: Text("Completed"))
            ],
          )
        ]),
      ),
    );
  }
}

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  List<bool> done = [true, true, true];
  List<Widget> _getChildren(int count, String name) => List<Widget>.generate(
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
                        value: done[i],
                        shape: CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            done[i] = value!;
                          });
                        },
                      ),
                    ),
                    Text('$name${i + 1}',
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
                      onPressed: () {},
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(23, 21, 22, 1),
        padding: EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(47, 43, 45, 1),
                                    border: Border.all(
                                      color: Color.fromRGBO(47, 43, 45, 1),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: ExpansionTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  // sets the color of the arrow when collapsed
                                  collapsedIconColor:
                                      Color.fromRGBO(228, 107, 103, 0.91),
                                  // sets the color of the arrow when expanded
                                  iconColor:
                                      Color.fromRGBO(228, 107, 103, 0.91),
                                  title: Text('Kategori ${index + 1}',
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              228, 107, 103, 0.91),
                                          fontSize: 12)),
                                  children: _getChildren(3, 'Tugas '),
                                ));
                          })),
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
    );
    ;
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool blockNotif = false, silentMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromRGBO(23, 21, 22, 1),
            padding: EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.settings,
                  color: Color.fromRGBO(159, 215, 227, 0.91),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Settings",
                    style: TextStyle(
                        color: Color.fromRGBO(159, 215, 227, 0.91),
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
                          child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(47, 43, 45, 1),
                                border: Border.all(
                                  color: Color.fromRGBO(47, 43, 45, 1),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Block Notification",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  Switch(
                                    value: blockNotif,
                                    onChanged: (value) {
                                      setState(() {
                                        blockNotif = value;
                                        //print(isSwitched);
                                      });
                                    },
                                    inactiveTrackColor: Colors.grey,
                                    activeTrackColor:
                                        Color.fromRGBO(159, 215, 227, 0.4),
                                    activeColor:
                                        Color.fromRGBO(159, 215, 227, 1),
                                  )
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(47, 43, 45, 1),
                                border: Border.all(
                                  color: Color.fromRGBO(47, 43, 45, 1),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Silent Mode",
                                      style: TextStyle(color: Colors.white)),
                                  Switch(
                                    value: silentMode,
                                    onChanged: (value) {
                                      setState(() {
                                        silentMode = value;
                                        //print(isSwitched);
                                      });
                                    },
                                    inactiveTrackColor: Colors.grey,
                                    activeTrackColor:
                                        Color.fromRGBO(159, 215, 227, 0.4),
                                    activeColor:
                                        Color.fromRGBO(159, 215, 227, 1),
                                  )
                                ]),
                          )
                        ],
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
            ])));
  }
}
