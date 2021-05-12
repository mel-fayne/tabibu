import 'package:Tabibu/app/screens/doctors/rescheduleappt.dart';
import 'package:Tabibu/app/screens/doctors/setappttime.dart';
import 'package:intl/intl.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SingleAppt extends StatefulWidget {
  static const routeName = "/singleappt";

  //accepting parameters from previous screen
  final String apptid;
  final String check;

  SingleAppt({@required this.apptid, @required this.check});
  @override
  State<StatefulWidget> createState() {
    return SingleApptState(this.apptid, this.check);
  }
}

class SingleApptState extends State<SingleAppt> {
  String apptid;
  String check;
  SingleApptState(this.apptid, this.check);

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

    if (check == "Done" || check == "Confirmed") {
      statcheck = true;
    }
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
              'More Appointment Details',
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
                              label: 'Doctor Name:',
                              text: 'Dr. $drname',
                            ),
                            textProfile(
                              label: 'Appointment Date:',
                              text: '$date',
                            ),
                            textProfile(
                              label: 'Appointment Reason:',
                              text: '$reason',
                            ),
                            statcheck
                                ? textProfile(
                                    label: 'Appointment Time:',
                                    text: '$time',
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Text(
                                      'Appointment Time yet to be confirmed!',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'PT Serif',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )),
                          ]);
                  }
                },
              )
            ]),
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
