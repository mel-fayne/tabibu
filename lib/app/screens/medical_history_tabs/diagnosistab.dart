import 'package:Tabibu/app/models/diagnosis.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/singlediagnosis.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lottie/lottie.dart';

class DiagnosisTab extends StatefulWidget {
  static const routeName = "/diagnosistab";
//accepting parameters from previous screen
  final String ptid;
  DiagnosisTab({@required this.ptid});
  @override
  State<StatefulWidget> createState() {
    return DiagnosisTabState(this.ptid);
  }
}

class DiagnosisTabState extends State<DiagnosisTab> {
  String ptid;
  String diagnosisid;
  DiagnosisTabState(this.ptid);

  @override
  void initState() {
    super.initState();
    getDiagnosisList();
  }

  List<Diagnosis> diagnosisdata = [];
  bool diagnosisno = false;

  getDiagnosisList() async {
    var url = "http://192.168.0.15/tabibu/api/diagnosis/getdiagnosis.php";
    var res = await http.post(url,
        body: {"pt_id": ptid}, headers: {"Accept": "application/json"});
    var diagnosis = json.decode(res.body);
    if (diagnosis == "no record") {
      diagnosisno = true;
      print('no record!');
    } else {
      for (var data in diagnosis) {
        diagnosisdata.add(new Diagnosis(
            data['disease'],
            data['description'],
            data['date'],
            data['weight'],
            data['temp'],
            data['pulse'],
            data['pressure'],
            data['symptoms'],
            data['medicine'],
            data['prescription'],
            data['treatmentinfo'],
            data['recordid'],
            data['dr_id'],
            data['pt_id'],
            data['status']));
      }
      setState(() {});
      diagnosisdata.forEach((someData) => print("Name : ${someData.recordid}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: 20),
      child: diagnosisno
          ? Padding(
              padding: EdgeInsets.only(top: 10, left: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'You have no Medical Cases!',
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
          : diagnosisdata.length == 0
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: kPrimaryGreen,
                ))
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: diagnosisdata.length,
                      itemBuilder: (_, index) {
                        return Card(
                            color: kPrimaryAccent,
                            elevation: 7.0,
                            child: ListTile(
                              leading: Icon(
                                Icons.healing,
                                color: kPrimaryYellow,
                                size: 45,
                              ),
                              title: Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: textProfile(
                                  label: 'Ailment/Condition:',
                                  text: '${diagnosisdata[index].disease}',
                                ),
                              ),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      '${diagnosisdata[index].description}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'PT Serif',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    textProfile(
                                      label: 'Date:',
                                      text: '${diagnosisdata[index].date}',
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: textProfile(
                                        label: 'Status:',
                                        text: '${diagnosisdata[index].status}',
                                      ),
                                    ),
                                  ]),
                              trailing: Icon(
                                Icons.arrow_right_outlined,
                                color: kPrimaryGreen,
                                size: 25,
                              ),
                              onTap: () {
                                diagnosisid = diagnosisdata[index].recordid;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleDiagnosis(
                                            diagid: diagnosisid)));
                              },
                            ));
                      })),
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
