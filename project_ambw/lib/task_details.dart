import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({Key? key}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  List listItem = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"];
  String? valueChoose;
  DateTime dateTime = DateTime(2022, 12, 24, 5, 30);

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    TextEditingController _dueDateTextField = TextEditingController();

    return MaterialApp(
        title: "focus session",
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
                                  onPressed: () {},
                                  child: Text("Cancel",
                                      style: TextStyle(fontSize: 18))),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(23, 21, 22, 1),
                                    alignment: Alignment.centerRight,
                                  ),
                                  onPressed: () {},
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
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            TextField(
                              readOnly: true,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 160, 158, 158)),
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
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xffFF2F2B2D), width: 1)),
                              child: DropdownButton(
                                hint: Text(
                                  "Select Category",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                dropdownColor: Color(0xffFF2F2B2D),
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                isExpanded: true,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                value: valueChoose,
                                onChanged: (newValue) {
                                  setState(() {
                                    valueChoose = newValue as String?;
                                  });
                                },
                                items: listItem.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem),
                                  );
                                }).toList(),
                              ),
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
                                        setState(() {
                                          dateTime.toString();
                                        });
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
}
