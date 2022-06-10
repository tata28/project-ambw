import 'package:flutter/material.dart';

class InSessionPage extends StatefulWidget {
  const InSessionPage({Key? key}) : super(key: key);

  @override
  State<InSessionPage> createState() => _InSessionPageState();
}

class _InSessionPageState extends State<InSessionPage> {
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
                                            "1 of 3",
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
                                          Text("05:49",
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
                                        onPressed: () {},
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
                                        "15 min break",
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
