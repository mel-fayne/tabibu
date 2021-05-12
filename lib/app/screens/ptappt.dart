import 'package:Tabibu/app/models/appointment.dart';
import 'package:Tabibu/app/screens/doctors/singleappointment.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lottie/lottie.dart';

class PtScheduleList extends StatefulWidget {
  static const routeName = "/ptschedulelist";

  //accepting parameters from previous screen
  final String ptid;

  PtScheduleList({@required this.ptid});
  @override
  State<StatefulWidget> createState() {
    return PtScheduleListState(this.ptid);
  }
}

class PtScheduleListState extends State<PtScheduleList> {
  String ptid;
  String apptid;
  PtScheduleListState(this.ptid);

  @override
  void initState() {
    super.initState();
    getUnconfAppt();
    getConfAppt();
    getDoneAppt();
  }

  List<Appointment> unconfdata = [];
  List<Appointment> confdata = [];
  List<Appointment> donedata = [];

  bool unconfno = false;
  bool confno = false;
  bool doneno = false;

  getUnconfAppt() async {
    var url = "http://192.168.0.15/tabibu/api/patients/getptunconfappt.php";
    var res = await http.post(url,
        body: {"patientid": ptid}, headers: {"Accept": "application/json"});
    var unconfappt = json.decode(res.body);
    if (unconfappt == "no appt on app" ||
        unconfappt == "all appt done or conf") {
      unconfno = true;
      print('either no appt on app! or all appt done or conf');
    } else {
      for (var data in unconfappt) {
        unconfdata.add(new Appointment(
            data['apptid'],
            data['patientid'],
            data['doctorid'],
            data['date'],
            data['time'],
            data['location'],
            data['reason'],
            data['status'],
            data['drname'],
            data['ptname']));
      }
      setState(() {});
      unconfdata
          .forEach((someData) => print("Unconf Appt : ${someData.apptid}"));
    }
  }

  getConfAppt() async {
    var url = "http://192.168.0.15/tabibu/api/patients/getptconfappt.php";
    var res = await http.post(url,
        body: {"patientid": ptid}, headers: {"Accept": "application/json"});
    var confappt = json.decode(res.body);
    if (confappt == "no appt on app" || confappt == "all appt conf or done") {
      confno = true;
      print('either no appt on app! or aall appt conf or done');
    } else {
      for (var data in confappt) {
        confdata.add(new Appointment(
            data['apptid'], //reason
            data['patientid'], //date
            data['doctorid'], //location
            data['date'], //ptid
            data['time'], //reason
            data['location'], //time
            data['reason'], //apptid
            data['status'], //drname
            data['drname'], //status
            data['ptname'])); //ptname
      }
      setState(() {});
      confdata.forEach((someData) => print("Conf Appt : ${someData.apptid}"));
    }
  }

  getDoneAppt() async {
    var url = "http://192.168.0.15/tabibu/api/patients/getptdoneappt.php";
    var res = await http.post(url,
        body: {"patientid": ptid}, headers: {"Accept": "application/json"});
    var doneappt = json.decode(res.body);
    if (doneappt == "no appt on app" || doneappt == "all appt conf or unconf") {
      doneno = true;
      print('either no appt on app! or all appt conf or unconf');
    } else {
      for (var data in doneappt) {
        donedata.add(new Appointment(
            data['apptid'],
            data['patientid'],
            data['doctorid'],
            data['date'],
            data['time'],
            data['location'],
            data['reason'],
            data['status'],
            data['drname'],
            data['ptname']));
      }
      setState(() {});
      donedata.forEach((someData) => print("Done Appt : ${someData.apptid}"));
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
                      "View Appointments",
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
                    'My Unconfirmed Appointment Requests',
                    style: TextStyle(
                      color: kPrimaryGreen,
                      fontSize: 18,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              unconfno
                  ? Padding(
                      padding: EdgeInsets.only(top: 10, left: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'You have no unconfirmed appointments!',
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
                          itemCount: unconfdata.length,
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
                                          text: '${unconfdata[index].ptname}',
                                        ),
                                        textProfile(
                                          label: 'Appointment Date:',
                                          text:
                                              '${unconfdata[index].patientid}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: textProfile(
                                      label: "Appointment Status:",
                                      text: '${unconfdata[index].drname}',
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_outlined,
                                    color: kPrimaryGreen,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    apptid = unconfdata[index].date;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleAppointment(
                                                    check: "Unconfirmed",
                                                    apptid: apptid)));
                                  },
                                ));
                          })),
              Padding(
                  padding: EdgeInsets.only(left: 3, top: 5),
                  child: Text(
                    'My Confirmed Appointments',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 18,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              confno
                  ? Padding(
                      padding: EdgeInsets.only(top: 10, left: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'You have no confirmed appointments!',
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
                          itemCount: confdata.length,
                          itemBuilder: (_, index) {
                            return Card(
                                color: Colors.pink[100],
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
                                          text: '${confdata[index].ptname}',
                                        ),
                                        textProfile(
                                          label: 'Appointment Date:',
                                          text: '${confdata[index].patientid}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Column(children: [
                                        textProfile(
                                          label: "Appointment Status:",
                                          text: '${confdata[index].drname}',
                                        ),
                                        textProfile(
                                          label: 'Appointment Time:',
                                          text: '${donedata[index].reason}',
                                        ),
                                      ])),
                                  trailing: Icon(
                                    Icons.arrow_right_outlined,
                                    color: kPrimaryGreen,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    apptid = confdata[index].date;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleAppointment(
                                                    check: "Confirmed",
                                                    apptid: apptid)));
                                  },
                                ));
                          })),
              Padding(
                  padding: EdgeInsets.only(left: 3, top: 5),
                  child: Text(
                    'Completed Appointments',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              doneno
                  ? Padding(
                      padding: EdgeInsets.only(top: 10, left: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'You have no complete appointments!',
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
                          itemCount: donedata.length,
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
                                          text: '${donedata[index].ptname}',
                                        ),
                                        textProfile(
                                          label: 'Appointment date:',
                                          text: '${donedata[index].patientid}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Column(children: [
                                        textProfile(
                                          label: 'Appointment Status:',
                                          text: '${donedata[index].drname}',
                                        ),
                                        textProfile(
                                          label: 'Appointment Time:',
                                          text: '${donedata[index].reason}',
                                        ),
                                      ])),
                                  trailing: Icon(
                                    Icons.arrow_right_outlined,
                                    color: kPrimaryGreen,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    apptid = donedata[index].date;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleAppointment(
                                                    check: "Done",
                                                    apptid: apptid)));
                                  },
                                ));
                          })),
            ])));
  }
}
