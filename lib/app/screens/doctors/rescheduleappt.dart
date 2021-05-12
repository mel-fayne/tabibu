import 'package:intl/intl.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class RescheduleAppt extends StatefulWidget {
  static const routeName = "/rescheduleappt";

  //accepting parameters from previous screen
  final String apptid;
  final String check;

  RescheduleAppt({@required this.apptid, @required this.check});
  @override
  State<StatefulWidget> createState() {
    return RescheduleApptState(this.apptid, this.check);
  }
}

class RescheduleApptState extends State<RescheduleAppt> {
  String apptid;
  String check;
  RescheduleApptState(this.apptid, this.check);

  String date;
  String time;
  String location;
  String reason;
  String drname;
  String ptname;

  bool processing = false;
  bool statcheck = false;

  DateTime selectedDate = DateTime.now();
  String formattedDate;
  TimeOfDay selectedTime = TimeOfDay.now();
  String formattedTime;

  @override
  void initState() {
    super.initState();
    getAppt();
    print(check);
  }

  Future getAppt() async {
    var url = "http://192.168.0.15/tabibu/api/appointments/getappointments.php";
    var res = await http.post(url, body: {"apptid": apptid});
    var appt = json.decode(res.body);
    if (appt == "inexistent") {
      print('Unexpected error occured!');
    } else {
      print("Yoooo! appt worked!");
      date = appt[3];
      time = appt[4];
      location = appt[5];
      reason = appt[6];
      drname = appt[8];
      ptname = appt[9];
      print(appt);
      if (check == "Done") {
        statcheck = true;
      }
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        final localizations = MaterialLocalizations.of(context);
        formattedTime = localizations.formatTimeOfDay(selectedTime);
      });
  }

  rescheduleDate() async {
    var url = "http://192.168.0.15/tabibu/api/appointments/reschedule.php";
    var res = await http.post(url,
        body: {"apptid": apptid, "time": formattedTime, "date": formattedDate});
    var reschconf = json.decode(res.body);
    if (reschconf == "error") {
      print('Unexpected error occured!');
    } else {
      print("Appt rescheduled!");
      return Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "Appointment succesfully Rescheduled!",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 56,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 20, left: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Reschedule Appointment Date',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'PT Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              FutureBuilder(
                future: getAppt(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: kPrimaryGreen,
                    ));
                  } else {
                    if (snapshot.hasError)
                      return Center(child: Text('Error: ${snapshot.error}'));
                    else
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Status:',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'PT Serif',
                                      fontWeight: FontWeight.w600,
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(left: 3),
                                    child: Text(
                                      "$check",
                                      style: TextStyle(
                                        color: kPrimaryGreen,
                                        fontSize: 14,
                                        fontFamily: 'Source Sans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                                statusLottie(
                                  stat: "$check",
                                ),
                              ],
                            ),
                            textProfile(
                              label: 'Patient Name:',
                              text: '$ptname',
                            ),
                            textProfile(
                              label: 'Appointment Date:',
                              text: '$date',
                            ),
                            textProfile(
                              label: 'Appointment Reason:',
                              text: '$reason',
                            ),
                            textProfile(
                              label: 'Appointment Time:',
                              text: '$time',
                            )
                          ]);
                  }
                },
              )
            ]),
            Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Column(children: [
                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      'Select Appointment Date',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    color: kPrimaryAccent,
                  ),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  RaisedButton(
                    onPressed: () => _selectTime(context),
                    child: Text(
                      'Select Appointment Time',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    color: kPrimaryAccent,
                  ),
                  Text(
                    "$selectedTime".split(' ')[0],
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 40,
                        onPressed: () {
                          setState(() {
                            processing = true;
                            debugPrint("reschedule button clicked");
                            rescheduleDate();
                          });
                        },
                        color: kPrimaryGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text("Confirm Appointment",
                            style: TextStyle(
                                color: kPrimaryYellow,
                                fontFamily: 'PT Serif',
                                fontSize: 20,
                                fontWeight: FontWeight.w700)),
                      ))
                ])),
          ])),
    );
  }
}

Widget statusLottie({stat}) {
  String path;
  if (stat == "Done") {
    path = 'assets/lottie/22921-happy-girlpeaceful.json';
  } else {
    path = 'assets/lottie/30995-doctor-and-patient-conversation.json';
  }
  return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            path,
            repeat: true,
            reverse: true,
            animate: true,
            width: 150,
            height: 150,
          )
        ],
      ));
}

Widget textProfile({label, text}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Text(label,
            style: TextStyle(
              color: kFieldTextColor,
              fontSize: 13,
              fontFamily: 'PT Serif',
              fontWeight: FontWeight.w600,
            )),
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Source Sans',
                fontWeight: FontWeight.w600,
              ),
            ))
      ],
    ),
  );
}
