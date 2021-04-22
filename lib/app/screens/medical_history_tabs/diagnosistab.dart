import 'package:Tabibu/app/screens/doctors/newrecord.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DiagnosisTab extends StatefulWidget {
  static const routeName = "/diagnosistab";

  @override
  _DiagnosisTabState createState() => _DiagnosisTabState();
}

class _DiagnosisTabState extends State<DiagnosisTab> {
  Map data;
  List diagnosisData;

  Future getData() async {
    http.Response response = await http
        .get("http://192.168.0.15/tabibu/api/diagnosis/getdiagnosis.php");
    data = json.decode(response.body);
    setState(() {
      diagnosisData = data["   "];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: diagnosisData == null ? 0 : diagnosisData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: Icon(
                MyCustomIcons.health_report,
                color: kPrimaryGreen,
                size: 55,
              ),
              title: Text("Diagnosis: ...\nTreatment: ...",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              subtitle: Column(
                children: [
                  Text("Description: ...",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Date: ...",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                              color: kFieldTextColor))),
                ],
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right_outlined,
                color: kPrimaryGreen,
                size: 34,
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                //  navigateToDetail(this.diagnosisList[position]);
              },
            ),
          );
        },
      ),
    );
  }
}
