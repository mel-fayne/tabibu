import 'package:Tabibu/app/models/update.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/singleupdate.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lottie/lottie.dart';

class MyUpdatesTab extends StatefulWidget {
  static const routeName = "/myupdatestab";

//accepting parameters from previous screen
  final String ptid;
  MyUpdatesTab({@required this.ptid});
  @override
  State<StatefulWidget> createState() {
    return MyUpdatesTabState(this.ptid);
  }
}

class MyUpdatesTabState extends State<MyUpdatesTab> {
  String ptid;
  String updid;
  MyUpdatesTabState(this.ptid);

  @override
  void initState() {
    super.initState();
    getUpdates();
    getSeenUpdt();
  }

  List<Update> updatedata = [];
  List<Update> seenupdatedata = [];

  bool unseenno = false;
  bool seenno = false;

  getUpdates() async {
    var url = "http://192.168.0.15/tabibu/api/patients/getunseenupdt.php";
    var res = await http.post(url,
        body: {"patientid": ptid}, headers: {"Accept": "application/json"});
    var updt = json.decode(res.body);
    if (updt == "no update on app" || updt == "all updates seen") {
      unseenno = true;
      print('either no update on app! or all updates seen');
    } else {
      for (var data in updt) {
        updatedata.add(new Update(
          data['updateid'],
          data['patientid'],
          data['doctorid'],
          data['date'],
          data['feel'],
          data['partache'],
          data['painrate'],
          data['newsymptom'],
          data['sideeffect'],
          data['medintake'],
          data['additional'],
          data['status'],
          data['drname'],
          data['ptname'],
        ));
      }
      setState(() {});
      updatedata.forEach((someData) => print("Update : ${someData.updateid}"));
    }
  }

  getSeenUpdt() async {
    var url = "http://192.168.0.15/tabibu/api/patients/getptseenupdt.php";
    var res = await http.post(url,
        body: {"patientid": ptid}, headers: {"Accept": "application/json"});
    var seenupdt = json.decode(res.body);
    if (seenupdt == "no update on app" || seenupdt == "all updates seen") {
      seenno = true;
      print('either no update on app! or all updates seen');
    } else {
      for (var data in seenupdt) {
        seenupdatedata.add(new Update(
          data['updateid'],
          data['patientid'],
          data['doctorid'],
          data['date'],
          data['feel'],
          data['partache'],
          data['painrate'],
          data['newsymptom'],
          data['sideeffect'],
          data['medintake'],
          data['additional'],
          data['status'],
          data['drname'],
          data['ptname'],
        ));
      }
      setState(() {});
      seenupdatedata
          .forEach((someData) => print("Update : ${someData.updateid}"));
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
                      "View Updates",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'PT Serif',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 3, top: 20),
                  child: Text(
                    'My Unseen Patient Updates',
                    style: TextStyle(
                      color: kPrimaryGreen,
                      fontSize: 18,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              unseenno
                  ? Padding(
                      padding: EdgeInsets.only(top: 10, left: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'You have no unseen updates!',
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
                          itemCount: updatedata.length,
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
                                          text: '${updatedata[index].ptname}',
                                        ),
                                        textProfile(
                                          label: 'Update Date:',
                                          text: '${updatedata[index].date}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: textProfile(
                                      label: "Update Status:",
                                      text: '${updatedata[index].status}',
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_outlined,
                                    color: kPrimaryGreen,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    updid = updatedata[index].updateid;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SingleUpdate(
                                                check: "Unseen",
                                                updid: updid)));
                                  },
                                ));
                          })),
              Padding(
                  padding: EdgeInsets.only(left: 3, top: 5),
                  child: Text(
                    'Seen Updates',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              seenno
                  ? Padding(
                      padding: EdgeInsets.only(top: 10, left: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'You have no unseen updates!',
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
                          itemCount: seenupdatedata.length,
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
                                          text:
                                              '${seenupdatedata[index].ptname}',
                                        ),
                                        textProfile(
                                          label: 'Update date:',
                                          text: '${seenupdatedata[index].date}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: textProfile(
                                      label: 'Update Status:',
                                      text: '${seenupdatedata[index].status}',
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_outlined,
                                    color: kPrimaryGreen,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    updid = seenupdatedata[index].updateid;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SingleUpdate(
                                                check: "Seen", updid: updid)));
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
