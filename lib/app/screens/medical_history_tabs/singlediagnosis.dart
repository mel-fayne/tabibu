import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SingleDiagnosis extends StatefulWidget {
  static const routeName = "/singlediagnosis";

//accepting parameters from previous screen
  final String diagid;
  SingleDiagnosis({@required this.diagid});
  @override
  State<StatefulWidget> createState() {
    return SingleDiagnosisState(this.diagid);
  }
}

class SingleDiagnosisState extends State<SingleDiagnosis> {
  String diagid;
  SingleDiagnosisState(this.diagid);

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

  @override
  void initState() {
    super.initState();
    getDiagnosis();
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
      print(diagnosis);

      var docurl = "http://192.168.0.15/tabibu/api/doctors/getdocid.php";
      var docres = await http.post(docurl, body: {"doctorid": dr_id});
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
      var ptres = await http.post(pturl, body: {"patient_id": pt_id});
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
        padding: EdgeInsets.only(top: 20, left: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                              'Diagnosis Details',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.local_hospital_rounded,
                              color: kPrimaryGreen,
                              size: 20,
                            ))
                      ],
                    ),
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
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textProfile(
                                    label: "Patient ID:",
                                    text: "$pt_id",
                                  ),
                                  textProfile(
                                    label: 'Patient Name',
                                    text: 'Dr. $ptname',
                                  ),
                                  textProfile(
                                    label: 'Doctor ID',
                                    text: '$dr_id',
                                  ),
                                  textProfile(
                                    label: 'Doctor Name',
                                    text: 'Dr. $drname',
                                  ),
                                  textProfile(
                                    label: 'Date',
                                    text: '$date',
                                  ),
                                  textProfile(
                                    label: 'Ailment:',
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
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Vitals & Symptoms',
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
                                                MyCustomIcons.list,
                                                color: kPrimaryGreen,
                                                size: 20,
                                              ))
                                        ],
                                      )),
                                  textProfile(
                                    label: 'Temperature:',
                                    text: '$temp degrees celcius',
                                  ),
                                  textProfile(
                                    label: 'Blood pressure:',
                                    text: '$pressure mmHg',
                                  ),
                                  textProfile(
                                    label: 'Pulse rate:',
                                    text: '$pulse beats per minute',
                                  ),
                                  textProfile(
                                    label: 'Weight:',
                                    text: '$weight Kgs',
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Symptoms:',
                                          style: TextStyle(
                                            color: kFieldTextColor,
                                            fontSize: 13,
                                            fontFamily: 'PT Serif',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '$symptoms',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Source Sans',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ]),
                                  Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Treatment',
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
                                                MyCustomIcons.pill,
                                                color: kPrimaryGreen,
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
                                ]);
                        }
                      },
                    )
                  ]))
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
