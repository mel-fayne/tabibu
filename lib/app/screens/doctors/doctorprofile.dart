import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorProfile extends StatefulWidget {
  static const routeName = "/doctorprofile";

//accepting parameters from previous screen
  final String userid;
  DoctorProfile({@required this.userid});
  @override
  State<StatefulWidget> createState() {
    return DoctorProfileState(this.userid);
  }
}

class DoctorProfileState extends State<DoctorProfile> {
  String userid;
  DoctorProfileState(this.userid);

  //user details
  String fullname;
  String email;
  String county;
  //doctor details
  int doctorid;
  String hospital;
  String specialty;
  String pracyrs;
  String about;
  String liscence;
  String days;
  String time;

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

    var docurl = "http://192.168.0.15/tabibu/api/doctors/getdoctors.php";
    var docres = await http.post(docurl, body: {"userid": userid});
    var docdata = json.decode(docres.body);
    if (docdata == "error") {
      print("sth went wrong!");
    } else {
      print("Yoooo! It worked!");
      doctorid = int.parse(docdata[0]);
      hospital = docdata[1];
      specialty = docdata[2];
      pracyrs = docdata[3];
      about = docdata[4];
      liscence = docdata[5];
      days = docdata[6];
      time = docdata[7];
      print(docdata);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, left: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                        )
                      ]),
                  textProfile(
                    label: "User ID:",
                    text: "$userid",
                  ),
                  FutureBuilder(
                    future: getUser(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(
                          backgroundColor: kPrimaryGreen,
                        );
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
                                text: "Doctor Account",
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Doctor Details',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Pt Serif',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 3),
                                          child: Icon(
                                            Icons.medical_services,
                                            color: kPrimaryGreen,
                                            size: 24,
                                          ))
                                    ],
                                  )),
                              textProfile(
                                label: "Doctor ID:",
                                text: "$doctorid",
                              ),
                              textProfile(
                                label: "Base Hospital:",
                                text: "$hospital",
                              ),
                              textProfile(
                                label: "Specialty:",
                                text: "$specialty",
                              ),
                              textProfile(
                                label: "Years of Medical Practice:",
                                text: "$pracyrs years",
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'About me:',
                                          style: TextStyle(
                                            color: kFieldTextColor,
                                            fontSize: 11,
                                            fontFamily: 'PT Serif',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '$about',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'PT Serif',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ])),
                              textProfile(
                                label: "Doctor Liscence ID:",
                                text: "$liscence",
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child: Text(
                                    'Availability Stats',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'PT Serif',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                              textProfile(
                                label: "Days Available:",
                                text: "$days",
                              ),
                              textProfile(
                                label: "Time available:",
                                text: "$time",
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
