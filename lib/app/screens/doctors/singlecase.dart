import 'package:Tabibu/app/screens/medical_history_tabs/medicalhistory.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SingleCase extends StatefulWidget {
  static const routeName = "/singlediagnosis";

//accepting parameters from previous screen
  final String diagid;
  final String check;
  SingleCase({@required this.diagid, @required this.check});
  @override
  State<StatefulWidget> createState() {
    return SingleCaseState(this.diagid, this.check);
  }
}

class SingleCaseState extends State<SingleCase> {
  String diagid;
  String check;
  SingleCaseState(this.diagid, this.check);

  String disease;
  String description;
  String date;
  String weight;
  String temp;
  String pulse;
  String pressure;
  String symptoms;
  String medicine;
  String prescription;
  String treatmentinfo;
  String recordid;
  String dr_id;
  String pt_id;

  String drname;
  String ptname;
  String hospital;
  String docuserid;
  String ptuserid;

  bool processing = false;

  @override
  void initState() {
    super.initState();
    getDiagnosis();
    print(check);
  }

  Future getDiagnosis() async {
    var url = "http://192.168.0.15/tabibu/api/diagnosis/getsinglediagnosis.php";
    var res = await http.post(url, body: {"recordid": diagid});
    var diagnosis = json.decode(res.body);
    if (diagnosis == "error") {
      print('Unexpected error occured!');
    } else {
      print("Yoooo! diagnosis worked!");
      disease = diagnosis[1];
      description = diagnosis[2];
      date = diagnosis[3];
      weight = diagnosis[4];
      temp = diagnosis[5];
      pulse = diagnosis[6];
      pressure = diagnosis[7];
      symptoms = diagnosis[8];
      medicine = diagnosis[9];
      prescription = diagnosis[10];
      treatmentinfo = diagnosis[11];
      dr_id = diagnosis[12];
      pt_id = diagnosis[13];
      ptname = diagnosis[14];
      drname = diagnosis[15];
      hospital = diagnosis[16];
      print(diagnosis);
    }
  }

  closeCase() async {
    var url = "http://192.168.0.15/tabibu/api/diagnosis/closecase.php";
    var res = await http.post(url, body: {"recordid": diagid});
    var closed = json.decode(res.body);
    if (closed == "error") {
      print('Unexpected error occured!');
    } else {
      print("Closed!");
      Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "Case successfully closed!",
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'More Case Details',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'PT Serif',
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              )),
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: getDiagnosis(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor: kPrimaryGreen,
                          ));
                        } else {
                          if (snapshot.hasError)
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          else
                            return Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MedicalHistory(
                                                      ptid: pt_id,
                                                      fullname: ptname),
                                            ));
                                      },
                                      child: Text(
                                        "View $ptname 's Medical History",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Source Sans',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      color: kPrimaryAccent,
                                    ),
                                  ),
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
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "$check",
                                            style: TextStyle(
                                              color: kPrimaryGreen,
                                              fontSize: 14,
                                              fontFamily: 'Source Sans',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ))
                                    ],
                                  ),
                                  statusLottie(
                                    stat: "$check",
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Text(
                                            'Diagnosis Details',
                                            style: TextStyle(
                                              color: kPrimaryGreen,
                                              fontSize: 16,
                                              fontFamily: 'PT Serif',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Icon(
                                            Icons.local_hospital_rounded,
                                            color: kPrimaryAccent,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textProfile(
                                          label: 'Patient Name:',
                                          text: '$ptname',
                                        ),
                                        textProfile(
                                          label: 'Doctor Name:',
                                          text: 'Dr. $drname',
                                        ),
                                        textProfile(
                                          label: 'Hospital:',
                                          text: '$hospital',
                                        ),
                                        textProfile(
                                          label: 'Date:',
                                          text: '$date',
                                        ),
                                        textProfile(
                                          label: 'Ailment/Condition:',
                                          text: '$disease',
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Description:',
                                                style: TextStyle(
                                                  color: kFieldTextColor,
                                                  fontSize: 13,
                                                  fontFamily: 'PT Serif',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                '$description',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Source Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ]),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Vitals & Symptoms',
                                                  style: TextStyle(
                                                    color: kPrimaryGreen,
                                                    fontSize: 16,
                                                    fontFamily: 'Pt Serif',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 3),
                                                    child: Icon(
                                                      MyCustomIcons.list,
                                                      color: kPrimaryAccent,
                                                      size: 20,
                                                    ))
                                              ],
                                            )),
                                        Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(185.0),
                                            border: TableBorder.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: 1.5),
                                            children: [
                                              TableRow(children: [
                                                vital(vital: "Temperature"),
                                                stats(
                                                  stat: "$temp degrees celcius",
                                                )
                                              ]),
                                              TableRow(children: [
                                                vital(vital: 'Blood pressure'),
                                                stats(stat: '$pressure mmHg')
                                              ]),
                                              TableRow(children: [
                                                vital(
                                                  vital: 'Pulse rate',
                                                ),
                                                stats(
                                                    stat:
                                                        '$pulse beats per minute'),
                                              ]),
                                              TableRow(children: [
                                                vital(vital: 'Weight'),
                                                stats(stat: '$weight Kgs')
                                              ]),
                                              TableRow(children: [
                                                vital(vital: 'Symptoms'),
                                                stats(stat: '$symptoms')
                                              ]),
                                            ]),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Treatment',
                                                  style: TextStyle(
                                                    color: kPrimaryGreen,
                                                    fontSize: 16,
                                                    fontFamily: 'PT Serif',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 3),
                                                    child: Icon(
                                                      MyCustomIcons.pill,
                                                      color: kPrimaryAccent,
                                                      size: 20,
                                                    ))
                                              ],
                                            )),
                                        textProfile(
                                          label: 'Medicine:',
                                          text: '$medicine',
                                        ),
                                        textProfile(
                                            label: 'Prescription:',
                                            text: '$prescription'),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Additional Treatment Information:',
                                                style: TextStyle(
                                                  color: kFieldTextColor,
                                                  fontSize: 13,
                                                  fontFamily: 'PT Serif',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                '$treatmentinfo',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Source Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ]),
                                      ])
                                ]));
                        }
                      },
                    )
                  ])),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: check == "Closed"
                ? Container(
                    padding: EdgeInsets.only(top: 10),
                  )
                : MaterialButton(
                    minWidth: double.infinity,
                    height: 40,
                    onPressed: () {
                      setState(() {
                        processing = true;
                        debugPrint("Close case button clicked");
                        closeCase();
                      });
                    },
                    color: kPrimaryAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text("Close Case",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'PT Serif',
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                  ),
          )
        ]),
      ),
    );
  }
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

Widget statusLottie({stat}) {
  String path;
  if (stat == "Closed") {
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

Widget vital({vital}) {
  return Column(children: [
    Padding(
      padding: EdgeInsets.all(5),
      child: Text(vital,
          style: TextStyle(
            color: kFieldTextColor,
            fontSize: 13,
            fontFamily: 'PT Serif',
            fontWeight: FontWeight.w600,
          )),
    )
  ]);
}

Widget stats({stat}) {
  return Column(children: [
    Padding(
      padding: EdgeInsets.all(5),
      child: Text(stat,
          style: TextStyle(
            color: kPrimaryGreen,
            fontSize: 14,
            fontFamily: 'Source Sans',
            fontWeight: FontWeight.w600,
          )),
    )
  ]);
}
