import 'package:Tabibu/app/models/diagnosis.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class TreatmentTab extends StatefulWidget {
  static const routeName = "/treatmenttab";
//accepting parameters from previous screen
  final String ptid;
  TreatmentTab({@required this.ptid});
  @override
  State<StatefulWidget> createState() {
    return TreatmentTabState(this.ptid);
  }
}

class TreatmentTabState extends State<TreatmentTab> {
  String ptid;
  TreatmentTabState(this.ptid);

  @override
  void initState() {
    super.initState();
    getDiagnosisList();
  }

  List<Diagnosis> diagnosisdata = [];

  getDiagnosisList() async {
    var url = "http://192.168.0.15/tabibu/api/diagnosis/getdiagnosis.php";
    var res = await http.post(url,
        body: {"pt_id": ptid}, headers: {"Accept": "application/json"});
    var diagnosis = json.decode(res.body);
    if (diagnosis == "error") {
      print('Unexpected error occured!');
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
      child: diagnosisdata.length == 0
          ? Center(
              child: Text('Oops, No record yet!',
                  style: TextStyle(
                    fontFamily: 'PT Serif',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryGreen,
                  )))
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: diagnosisdata.length,
                  itemBuilder: (_, index) {
                    return Card(
                        color: Colors.blue[100],
                        elevation: 7.0,
                        child: ListTile(
                          leading: Icon(
                            MyCustomIcons.pill,
                            color: kPrimaryGreen,
                            size: 35,
                          ),
                          title: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textProfile(
                                    label: 'Ailment/Condition:',
                                    text: '${diagnosisdata[index].disease}',
                                  ),
                                  textProfile(
                                    label: 'Medicine:',
                                    text: '${diagnosisdata[index].medicine}',
                                  ),
                                  textProfile(
                                      label: 'Prescription:',
                                      text:
                                          '${diagnosisdata[index].prescription}'),
                                ],
                              )),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                        '${diagnosisdata[index].treatmentinfo}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Source Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ]),
                                textProfile(
                                  label: 'Medication Status:',
                                  text:
                                      'Case is ${diagnosisdata[index].status}',
                                ),
                              ]),
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
