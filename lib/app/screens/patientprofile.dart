import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientProfile extends StatefulWidget {
  static const routeName = "/patientprofile";

//accepting parameters from previous screen
  final String userid;
  PatientProfile({@required this.userid});
  @override
  State<StatefulWidget> createState() {
    return PatientProfileState(this.userid);
  }
}

class PatientProfileState extends State<PatientProfile> {
  String userid;
  PatientProfileState(this.userid);

  String fullname;
  String email;
  String county;
  //patient details
  int patientid;
  String condtype;
  String condname;
  String bloodtype;
  String paymode;

  Future getUser() async {
    var url = "http://192.168.0.15/tabibu/api/auth/getuser.php";
    var res = await http.post(url, body: {"userid": userid});
    var data = json.decode(res.body);
    if (data == "error") {
      print("sth went wrong!");
    } else {
      print("Yoooo! It worked!");
      fullname = data[0];
      email = data[1];
      county = data[2];
      print(data);
    }

    var pturl = "http://192.168.0.15/tabibu/api/patients/getpatients.php";
    var ptres = await http.post(pturl, body: {"userid": userid});
    var ptdata = json.decode(ptres.body);
    if (ptdata == "error") {
      print("sth went wrong!");
    } else {
      print("Yoooo! It worked!");
      patientid = int.parse(ptdata[0]);
      condtype = ptdata[1];
      condname = ptdata[2];
      bloodtype = ptdata[3];
      paymode = ptdata[4];
      print(ptdata);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, left: 20),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PT Serif',
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'My User Details',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Pt Serif',
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            MyCustomIcons.profile_user,
                            color: kPrimaryGreen,
                            size: 20,
                          ))
                    ],
                  ),
                  textProfile(
                    label: "User ID:",
                    text: "$userid",
                  ),
                  FutureBuilder(
                    future: getUser(),
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
                              child: Text('Error: ${snapshot.error}'));
                        else
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textProfile(
                                label: "Name:",
                                text: "$fullname",
                              ),
                              textProfile(
                                label: "Email Adress:",
                                text: "$email",
                              ),
                              textProfile(
                                label: "Residence County:",
                                text: "$county",
                              ),
                              textProfile(
                                label: "Account Type:",
                                text: "Patient Account",
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        'My Patient Details',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Pt Serif',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Icon(
                                            Icons.medical_services,
                                            color: kPrimaryGreen,
                                            size: 24,
                                          ))
                                    ],
                                  )),
                              textProfile(
                                label: "Patient ID:",
                                text: "$patientid",
                              ),
                              textProfile(
                                label: "Condition Type:",
                                text: "$condtype",
                              ),
                              textProfile(
                                label: "Condition Name:",
                                text: "$condname",
                              ),
                              textProfile(
                                label: "Blood Type:",
                                text: "$bloodtype",
                              ),
                              textProfile(
                                label: "Payment Mode:",
                                text: "$paymode",
                              ),
                            ],
                          );
                      }
                    },
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}

Widget textProfile({label, text}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        Text(label,
            style: TextStyle(
              color: kFieldTextColor,
              fontSize: 11,
              fontFamily: 'PT Serif',
              fontWeight: FontWeight.w600,
            )),
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Source Sans',
                fontWeight: FontWeight.w600,
              ),
            ))
      ],
    ),
  );
}
