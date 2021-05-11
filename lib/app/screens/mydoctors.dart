import 'package:Tabibu/app/models/docuser.dart';
import 'package:Tabibu/app/screens/singledoctor.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MyDoctors extends StatefulWidget {
  static const routeName = "/mydoctors";

  //accepting parameters from previous screen
  final String ptid;

  MyDoctors({@required this.ptid});
  @override
  State<StatefulWidget> createState() {
    return MyDoctorsState(this.ptid);
  }
}

class MyDoctorsState extends State<MyDoctors> {
  String ptid;
  String drid;
  MyDoctorsState(this.ptid);
  TextEditingController searchctrl;

  @override
  void initState() {
    super.initState();
    searchctrl = TextEditingController();
    getMyDoctors();
    getAllDoctors();
  }

  List<Docuser> mydocdata = [];
  List<Docuser> alldocdata = [];

  getMyDoctors() async {
    var url = "http://192.168.0.15/tabibu/api/patients/getmydoctors.php";
    var res = await http.post(url,
        body: {"pt_id": ptid}, headers: {"Accept": "application/json"});
    var mydoc = json.decode(res.body);
    if (mydoc == "no doctors on app") {
      print('no doctors on app!');
    } else {
      for (var data in mydoc) {
        mydocdata.add(new Docuser(
            data['name'],
            data['hospital'],
            data['specialty'],
            data['practiceyrs'],
            data['pt_id'],
            data['dr_id'],
            data['']));
      }
      setState(() {});
      mydocdata.forEach((someData) => print("MyDoc : ${someData.dr_id}"));
    }
  }

  getAllDoctors() async {
    var url = "http://192.168.0.15/tabibu/api/doctors/getalldoctors.php";
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var alldoc = json.decode(res.body);
    if (alldoc == "no doctors") {
      print('no doctors!');
    } else {
      for (var data in alldoc) {
        alldocdata.add(new Docuser(
            data['name'],
            data['hospital'],
            data['specialty'],
            data['practiceyrs'],
            data['pt_id'],
            data[''],
            data['doctorid']));
      }
      setState(() {});
      alldocdata.forEach((someData) => print("AllDoc : ${someData.doctorid}"));
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "View Doctors",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'PT Serif',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: TextField(
              cursorColor: kPrimaryGreen,
              controller: searchctrl,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Source Sans',
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              onChanged: (value) {
                debugPrint('something changed in this feld');
              },
              decoration: InputDecoration(
                  labelText: "Search Doctors",
                  labelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w400,
                      color: kFieldTextColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 3, top: 5),
              child: Text(
                'My Doctors',
                style: TextStyle(
                  color: kPrimaryGreen,
                  fontSize: 18,
                  fontFamily: 'Source Sans',
                  fontWeight: FontWeight.w600,
                ),
              )),
          mydocdata.length == 0
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: kPrimaryGreen,
                ))
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: mydocdata.length,
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
                                      label: 'Name:',
                                      text: '${mydocdata[index].name}',
                                    ),
                                    textProfile(
                                      label: 'Hospital:',
                                      text: '${mydocdata[index].hospital}',
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: textProfile(
                                label: 'Specialty:',
                                text: '${mydocdata[index].specialty}',
                              ),
                              trailing: Icon(
                                Icons.arrow_right_outlined,
                                color: kPrimaryGreen,
                                size: 25,
                              ),
                              onTap: () {
                                drid = mydocdata[index].dr_id;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleDoctor(
                                            docid: drid, ptid: ptid)));
                              },
                            ));
                      })),
          Padding(
              padding: EdgeInsets.only(left: 3, top: 5),
              child: Text(
                'All Doctors Available ...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Source Sans',
                  fontWeight: FontWeight.w600,
                ),
              )),
          alldocdata.length == 0
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: kPrimaryGreen,
                ))
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: alldocdata.length,
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
                                      label: 'Name:',
                                      text: '${alldocdata[index].name}',
                                    ),
                                    textProfile(
                                      label: 'Hospital:',
                                      text: '${alldocdata[index].hospital}',
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: textProfile(
                                label: 'Specialty:',
                                text: '${alldocdata[index].specialty}',
                              ),
                              trailing: Icon(
                                Icons.arrow_right_outlined,
                                color: kPrimaryGreen,
                                size: 25,
                              ),
                              onTap: () {
                                drid = alldocdata[index].doctorid;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleDoctor(
                                            docid: drid, ptid: ptid)));
                              },
                            ));
                      })),
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
