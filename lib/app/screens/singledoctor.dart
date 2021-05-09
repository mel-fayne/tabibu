import 'package:Tabibu/app/screens/bookappointment.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SingleDoctor extends StatefulWidget {
  static const routeName = "/singledoctor";

//accepting parameters from previous screen
  final String docid;
  final String ptid;
  SingleDoctor({@required this.docid, @required this.ptid});
  @override
  State<StatefulWidget> createState() {
    return SingleDoctorState(this.docid, this.ptid);
  }
}

class SingleDoctorState extends State<SingleDoctor> {
  String docid;
  String ptid;
  SingleDoctorState(this.docid, this.ptid);

  String name;
  String hospital;
  String specialty;
  String practiceyrs;
  String about;
  String liscence;
  String days;
  String time;

  @override
  void initState() {
    super.initState();
    getDoctor();
  }

  Future getDoctor() async {
    var url = "http://192.168.0.15/tabibu/api/doctors/getsingledoctor.php";
    var res = await http.post(url, body: {"doctorid": docid});
    var doctor = json.decode(res.body);
    if (doctor == "error") {
      print('Unexpected error occured!');
    } else {
      print("Yoooo! diagnosis worked!");
      name = doctor[0];
      hospital = doctor[1];
      specialty = doctor[2];
      practiceyrs = doctor[3];
      about = doctor[4];
      liscence = doctor[5];
      days = doctor[6];
      time = doctor[7];
      print(doctor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 5),
          child: Column(children: [
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(children: [
                  FutureBuilder(
                    future: getDoctor(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          backgroundColor: kPrimaryGreen,
                        ));
                      } else {
                        if (snapshot.hasError)
                          return Center(
                              child: Text('Error: ${snapshot.data} $docid'));
                        else
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Icon(MyCustomIcons.profile_user,
                                        size: 150, color: kPrimaryGreen)),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, bottom: 15),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          textProfile(
                                              label: 'Name:',
                                              text: 'Dr. $name'),
                                          textProfile(
                                              label: 'Base Hospital:',
                                              text: '$hospital'),
                                          textProfile(
                                              label:
                                                  'Years of Medical Practice:',
                                              text: '$practiceyrs'),
                                          textProfile(
                                              label: 'Specialty:',
                                              text: '$specialty'),
                                        ])),
                                Container(
                                    decoration: BoxDecoration(
                                      color: kPrimaryYellow,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 15, left: 10, right: 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text('About',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'PT Serif',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18))),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Card(
                                                      color: kPrimaryAccent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      elevation: 4,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 25),
                                                        child: ListTile(
                                                            title: Text(
                                                                '$about',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        'Source Sans',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black)),
                                                            subtitle: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 20,
                                                                        left:
                                                                            70),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      MyCustomIcons
                                                                          .calendar,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 30,
                                                                    ),
                                                                    Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          '$days\n$time',
                                                                          style: TextStyle(
                                                                              color: kFieldTextColor,
                                                                              fontFamily: 'Source Sans',
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w600),
                                                                        ))
                                                                  ],
                                                                ))),
                                                      ))),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 35),
                                                child: MaterialButton(
                                                  minWidth: double.infinity,
                                                  height: 40,
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BookAppointment(
                                                                    docid:
                                                                        docid,
                                                                    ptid: ptid,
                                                                    hospital:
                                                                        hospital,
                                                                    name: name,
                                                                    days: days,
                                                                    time:
                                                                        time)));
                                                  },
                                                  color: kPrimaryGreen,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Text(
                                                      "MAKE APPOINTMENT",
                                                      style: TextStyle(
                                                          color: kPrimaryYellow,
                                                          fontFamily:
                                                              'PT Serif',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ),
                                              ),
                                            ]))),
                              ]);
                      }
                    },
                  )
                ])),
          ])),
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
