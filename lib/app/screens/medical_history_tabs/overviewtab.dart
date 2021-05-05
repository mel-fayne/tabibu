import 'package:Tabibu/app/models/diagnosis.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class OverviewTab extends StatefulWidget {
  static const routeName = "/overviewtab";

//accepting parameters from previous screen
  final String ptid;
  OverviewTab({@required this.ptid});
  @override
  State<StatefulWidget> createState() {
    return OverviewTabState(this.ptid);
  }
}

class OverviewTabState extends State<OverviewTab> {
  String ptid;
  OverviewTabState(this.ptid);

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
        ));
      }
      setState(() {});
      diagnosisdata.forEach((someData) => print("Name : ${someData.recordid}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: diagnosisdata.length == 0
                ? Center(
                    child: Text('Oops, No record yet!',
                        style: TextStyle(
                          fontFamily: 'PT Serif',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryGreen,
                        )))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Diagnosis:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PT Serif',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22),
                            )),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
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
                                              label: 'Ailment:',
                                              text:
                                                  '${diagnosisdata[index].disease}',
                                            ),
                                          ),
                                          subtitle: Column(
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
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 5),
                                                    child: Text(
                                                      '${diagnosisdata[index].description}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'PT Serif',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )),
                                              ])));
                                })),
                        Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              'Treatment:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PT Serif',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22),
                            )),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: diagnosisdata.length,
                                itemBuilder: (_, index) {
                                  return Card(
                                      color: Colors.blue[100],
                                      elevation: 5.0,
                                      child: ListTile(
                                        leading: Icon(
                                          MyCustomIcons.pill,
                                          color: kPrimaryGreen,
                                          size: 35,
                                        ),
                                        title: Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: textProfile(
                                            label: 'Medicine:',
                                            text:
                                                '${diagnosisdata[index].medicine}',
                                          ),
                                        ),
                                        subtitle: Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: textProfile(
                                              label: 'Prescription:',
                                              text:
                                                  '${diagnosisdata[index].prescription}',
                                            )),
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
