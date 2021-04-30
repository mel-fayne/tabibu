import 'package:Tabibu/app/theme/colors.dart';
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

  bool show = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getDoctor();
  }

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
  }

  Future getDoctor() async {
    var url = "http://192.168.0.15/tabibu/api/doctors/getdoctors.php";
    var res = await http.post(url, body: {"userid": userid});
    var data = json.decode(res.body);
    if (data == "error") {
      print("sth went wrong!");
    } else {
      print("Yoooo! It worked!");
      doctorid = int.parse(data[0]);
      hospital = data[1];
      specialty = data[2];
      pracyrs = data[3];
      about = data[4];
      liscence = data[5];
      days = data[6];
      time = data[7];
      print(data);
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
      body: Container(
          padding: EdgeInsets.only(top: 20, left: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'My Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'PT Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'User Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'PT Serif',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.person,
                            color: kPrimaryGreen,
                            size: 16,
                          ))
                    ],
                  ),
                  Text(
                    'Name: $fullname \nEmail Adress: $email \nResidence County: $county \nUser ID: $userid \nAccount Type: Doctor',
                    style: TextStyle(
                      color: kFieldTextColor,
                      fontSize: 16,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Doctor Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Pt Serif',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.medical_services,
                            color: kPrimaryGreen,
                            size: 16,
                          ))
                    ],
                  ),
                  Text(
                    'Doctor ID: $doctorid \nBase Hospital: $hospital\nSpecialty: $specialty\n Years of Medical Practice: $pracyrs\n\nAbout me: \n$about\n\nDoctor Liscence ID: $liscence\nDays Available: $days\nTime available: $time',
                    style: TextStyle(
                      color: kFieldTextColor,
                      fontSize: 16,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                    child: MaterialButton(
                      // minWidth: double.infinity,
                      height: 40,
                      onPressed: () {
                        setState(() {
                          debugPrint("Show more...");
                          show = true;
                          getUser();
                          getDoctor();
                        });
                      },
                      color: kPrimaryGreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("Show more..",
                          style: TextStyle(
                              color: kPrimaryYellow,
                              fontFamily: 'PT Serif',
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
