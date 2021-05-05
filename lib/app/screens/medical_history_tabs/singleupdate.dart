import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SingleUpdate extends StatefulWidget {
  static const routeName = "/singleupdate";

//accepting parameters from previous screen
  final String updid;
  SingleUpdate({@required this.updid});
  @override
  State<StatefulWidget> createState() {
    return SingleUpdateState(this.updid);
  }
}

class SingleUpdateState extends State<SingleUpdate> {
  String updid;
  SingleUpdateState(this.updid);

  String updateid;
  String patientid;
  String doctorid;
  String date;
  String feel;
  String partache;
  String painrate;
  String newsymptom;
  String sideeffect;
  String medintake;
  String additional;
  String docid;
  String ptid;

  String drname;
  String ptname;
  String hospital;
  String docuserid;
  String ptuserid;

  @override
  void initState() {
    super.initState();
    getUpdate();
  }

  Future getUpdate() async {
    var url = "http://192.168.0.15/tabibu/api/updates/getsingleupdate.php";
    var res = await http.post(url, body: {"updateid": updid});
    var update = json.decode(res.body);
    if (update == "error") {
      print('Unexpected error occured!');
    } else {
      print("Yoooo! update worked!");
      patientid = update[1];
      doctorid = update[2];
      date = update[3];
      feel = update[4];
      partache = update[5];
      painrate = update[6];
      newsymptom = update[7];
      sideeffect = update[8];
      medintake = update[9];
      additional = update[10];
      print(update);

      var docurl = "http://192.168.0.15/tabibu/api/doctors/getdocid.php";
      var docres = await http.post(docurl, body: {"doctorid": doctorid});
      var docdata = json.decode(docres.body);
      if (docdata == "error") {
        print("sth went wrong!");
      } else {
        print("Yoooo! doctor worked!");
        hospital = docdata[0];
        docuserid = docdata[1];
        print(docdata);
      }

      var url = "http://192.168.0.15/tabibu/api/auth/getuser.php";
      var res = await http.post(url, body: {"userid": docuserid});
      var data = json.decode(res.body);
      if (data == "error") {
        print("sth went wrong!");
      } else {
        print("Yoooo! doc user worked!");
        drname = data[0];
        print(data);
      }

      var pturl = "http://192.168.0.15/tabibu/api/patients/getptid.php";
      var ptres = await http.post(pturl, body: {"patient_id": patientid});
      var ptdata = json.decode(ptres.body);
      if (ptdata == "error") {
        print("sth went wrong!");
      } else {
        print("Yoooo! patient worked!");
        ptuserid = ptdata[0];
        print(ptdata);
      }

      var urlp = "http://192.168.0.15/tabibu/api/auth/getuser.php";
      var resp = await http.post(urlp, body: {"userid": ptuserid});
      var datap = json.decode(resp.body);
      if (datap == "error") {
        print("sth went wrong!");
      } else {
        print("Yoooo! pt user worked!");
        ptname = datap[0];
        print(datap);
      }
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
          padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'More Diagnosis Details',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'PT Serif',
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                'General Update Details',
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
                      FutureBuilder(
                        future: getUpdate(),
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
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textProfile(
                                      label: "Patient ID:",
                                      text: "$patientid",
                                    ),
                                    textProfile(
                                      label: 'Patient Name:',
                                      text: '$ptname',
                                    ),
                                    textProfile(
                                      label: 'Doctor ID:',
                                      text: '$doctorid',
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
                                    Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Text(
                                              'Update Details',
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
                                          Text(
                                            'How you felt:',
                                            style: TextStyle(
                                              color: kFieldTextColor,
                                              fontSize: 13,
                                              fontFamily: 'PT Serif',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            '$feel',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Source Sans',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ]),
                                    textProfile(
                                      label: 'Body part with pain:',
                                      text: '$partache',
                                    ),
                                    textProfile(
                                      label:
                                          'Amount of pain you felt on a scale of 1 to 5:',
                                      text: '$painrate',
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'New symptoms at the time:',
                                            style: TextStyle(
                                              color: kFieldTextColor,
                                              fontSize: 13,
                                              fontFamily: 'PT Serif',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            '$newsymptom',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Source Sans',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ]),
                                    textProfile(
                                      label:
                                          'Treatment Side effects at the time:',
                                      text: '$sideeffect',
                                    ),
                                    textProfile(
                                      label:
                                          'Was the medicine taken as prescribed:',
                                      text: '$medintake',
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Additional Update Information:',
                                            style: TextStyle(
                                              color: kFieldTextColor,
                                              fontSize: 13,
                                              fontFamily: 'PT Serif',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            '$additional',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Source Sans',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ]),
                                  ]);
                          }
                        },
                      )
                    ]))
          ]),
        ));
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
