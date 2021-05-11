import 'package:Tabibu/app/models/ptuser.dart';
import 'package:Tabibu/app/screens/doctors/singlecase.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lottie/lottie.dart';

class MyPatients extends StatefulWidget {
  static const routeName = "/mypatients";

  //accepting parameters from previous screen
  final String drid;

  MyPatients({@required this.drid});
  @override
  State<StatefulWidget> createState() {
    return MyPatientsState(this.drid);
  }
}

class MyPatientsState extends State<MyPatients> {
  String drid;
  String diagid;
  String status;
  MyPatientsState(this.drid);

  @override
  void initState() {
    super.initState();
    getOpen();
    getClosed();
  }

  List<Patientuser> opendata = [];
  List<Patientuser> closeddata = [];

  bool openno = false;
  bool closedno = false;

  getOpen() async {
    var url = "http://192.168.0.15/tabibu/api/doctors/getopencases.php";
    var res = await http.post(url,
        body: {"dr_id": drid}, headers: {"Accept": "application/json"});
    var opencase = json.decode(res.body);
    if (opencase == "no cases on app" || opencase == "all cases closed") {
      openno = true;
      print('no patients on app or all cases closed!');
    } else {
      for (var data in opencase) {
        opendata.add(new Patientuser(data['patient_id'], data['name'],
            data['date'], data['disease'], data['status'], data['recordid']));
      }
      setState(() {});
      opendata.forEach((someData) => print("Opencase : ${someData.recordid}"));
    }
  }

  getClosed() async {
    var url = "http://192.168.0.15/tabibu/api/doctors/getmypatients.php";
    var res = await http.post(url,
        body: {"dr_id": drid}, headers: {"Accept": "application/json"});
    var closedcase = json.decode(res.body);
    if (closedcase == "no cases on app" || closedcase == "all cases open") {
      closedno = true;
      print('no patients on app or all cases open!');
    } else {
      for (var data in closedcase) {
        closeddata.add(new Patientuser(data['patient_id'], data['name'],
            data['date'], data['disease'], data['status'], data['recordid']));
      }
      setState(() {});
      closeddata
          .forEach((someData) => print("Closedcase : ${someData.recordid}"));
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
            padding: EdgeInsets.only(left: 15, bottom: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "View Medical Cases",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'PT Serif',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 3, top: 5),
                  child: Text(
                    'My Open Medical Cases',
                    style: TextStyle(
                      color: kPrimaryGreen,
                      fontSize: 18,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              openno
                  ? Padding(
                      padding: EdgeInsets.only(top: 10, left: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'You have no open medical cases!',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PT Serif',
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          Lottie.asset(
                            'assets/lottie/22921-happy-girlpeaceful.json',
                            repeat: true,
                            reverse: true,
                            animate: true,
                            width: 150,
                            height: 150,
                          )
                        ],
                      ))
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: opendata.length,
                          itemBuilder: (_, index) {
                            return Card(
                                color: kPrimaryAccent,
                                elevation: 7.0,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    //  backgroundImage: AssetImage("imagepath"),
                                    backgroundColor: kPrimaryGreen,
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Column(
                                      children: [
                                        textProfile(
                                          label: 'Patient Name:',
                                          text: '${opendata[index].name}',
                                        ),
                                        textProfile(
                                          label: 'Ailment/Condition:',
                                          text: '${opendata[index].disease}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Column(
                                      children: [
                                        textProfile(
                                          label: 'Diagnosis Date:',
                                          text: '${opendata[index].date}',
                                        ),
                                        textProfile(
                                          label: 'Case Status:',
                                          text: '${opendata[index].status}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_outlined,
                                    color: kPrimaryGreen,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    diagid = opendata[index].recordid;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SingleCase(
                                                  diagid: diagid,
                                                  check: "On Treatment",
                                                )));
                                  },
                                ));
                          })),
              Padding(
                  padding: EdgeInsets.only(left: 3, top: 5),
                  child: Text(
                    'Closed Cases',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              closedno
                  ? Padding(
                      padding: EdgeInsets.only(top: 10, left: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'You have no closed cases!',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PT Serif',
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          Lottie.asset(
                            'assets/lottie/22921-happy-girlpeaceful.json',
                            repeat: true,
                            reverse: true,
                            animate: true,
                            width: 150,
                            height: 150,
                          )
                        ],
                      ))
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: closeddata.length,
                          itemBuilder: (_, index) {
                            return Card(
                                color: Colors.blue[100],
                                elevation: 7.0,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    //  backgroundImage: AssetImage("imagepath"),
                                    backgroundColor: kPrimaryGreen,
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Column(
                                      children: [
                                        textProfile(
                                          label: 'Patient Name:',
                                          text: '${closeddata[index].name}',
                                        ),
                                        textProfile(
                                          label: 'Ailment/Condition:',
                                          text: '${closeddata[index].disease}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Column(
                                      children: [
                                        textProfile(
                                          label: 'Diagnosis Date:',
                                          text: '${closeddata[index].date}',
                                        ),
                                        textProfile(
                                          label: 'Case Status:',
                                          text: '${closeddata[index].status}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_outlined,
                                    color: kPrimaryGreen,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    diagid = closeddata[index].recordid;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SingleCase(
                                                  diagid: diagid,
                                                  check: "Closed",
                                                )));
                                  },
                                ));
                          })),
            ])));
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

/*  @override
  void initState() {
    super.initState();
    getClosedCases();
    getOpenCases();
  }

  List<Patientuser> closeddata = [];
  List<Patientuser> opendata = [];

  getClosedCases() async {
    var url = "http://192.168.0.15/tabibu/api/doctors/getmypatients.php";
    var res = await http.post(url,
        body: {"dr_id": drid}, headers: {"Accept": "application/json"});
    var closedcase = json.decode(res.body);
    if (closedcase == "no patients on app") {
      print('no patients on app!');
    } else {
      for (var data in closedcase) {
        closeddata.add(new Patientuser(data['patient_id'], data['name'],
            data['date'], data['disease'], data['status'], data['recordid']));
      }
      setState(() {});
      closeddata
          .forEach((someData) => print("Closedcase : ${someData.patient_id}"));
    }
  }

  getOpenCases() async {
    var url = "http://192.168.0.15/tabibu/api/doctors/getopencases.php";
    var res = await http.post(url,
        body: {"dr_id": drid}, headers: {"Accept": "application/json"});
    var opencase = json.decode(res.body);
    if (opencase == "no patients on app") {
      print('no patients on app!');
    } else {
      for (var data in opencase) {
        opendata.add(new Patientuser(data['patient_id'], data['name'],
            data['date'], data['disease'], data['status'], data['recordid']));
      }
      setState(() {});
      opendata.forEach((someData) => print("Opencase : ${someData.recordid}"));
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
            padding: EdgeInsets.only(left: 15, bottom: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "View Medical Cases",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'PT Serif',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 3, top: 5),
                  child: Text(
                    'My Open Cases',
                    style: TextStyle(
                      color: kPrimaryGreen,
                      fontSize: 18,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              opendata.length == 0
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: kPrimaryGreen,
                    ))
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: closeddata.length,
                          itemBuilder: (_, index) {
                            return Card(
                                color: kPrimaryAccent,
                                elevation: 7.0,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    //  backgroundImage: AssetImage("imagepath"),
                                    backgroundColor: kPrimaryGreen,
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Column(
                                      children: [
                                        textProfile(
                                          label: 'Patient Name:',
                                          text: '${opendata[index].name}',
                                        ),
                                        textProfile(
                                          label: 'Date of Diagnosis:',
                                          text: '${opendata[index].date}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Column(
                                      children: [
                                        textProfile(
                                          label: 'Ailment/Condition:',
                                          text: '${opendata[index].disease}',
                                        ),
                                        textProfile(
                                          label: 'Case Status:',
                                          text: '${opendata[index].status}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_outlined,
                                    color: kPrimaryGreen,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    diagid = opendata[index].recordid;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleCase(diagid: diagid)));
                                  },
                                ));
                          })),
              Padding(
                  padding: EdgeInsets.only(left: 3, top: 5),
                  child: Text(
                    'My Closed Cases',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              closeddata.length == 0
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: kPrimaryGreen,
                    ))
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: closeddata.length,
                          itemBuilder: (_, index) {
                            return Card(
                                color: Colors.blue[100],
                                elevation: 7.0,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    //  backgroundImage: AssetImage("imagepath"),
                                    backgroundColor: kPrimaryGreen,
                                  ),
                                  title: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Column(
                                      children: [
                                        textProfile(
                                          label: 'Patient Name:',
                                          text: '${closeddata[index].name}',
                                        ),
                                        textProfile(
                                          label: 'Date of diagnosis:',
                                          text: '${closeddata[index].date}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Column(
                                      children: [
                                        textProfile(
                                          label: 'Ailment/Condition:',
                                          text: '${closeddata[index].disease}',
                                        ),
                                        textProfile(
                                          label: 'Case Status:',
                                          text: '${closeddata[index].status}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_outlined,
                                    color: kPrimaryGreen,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    diagid = closeddata[index].recordid;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleCase(diagid: diagid)));
                                  },
                                ));
                          })),
            ])));
  }
}
 */
