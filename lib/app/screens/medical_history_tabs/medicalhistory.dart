import 'package:Tabibu/app/screens/medical_history_tabs/diagnosistab.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/myupdatestab.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/overviewtab.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/treatmenttab.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class MedicalHistory extends StatefulWidget {
  static const routeName = "/medicalhistory";

  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(children: [
                Icon(MyCustomIcons.profile_user,
                    size: 30, color: kPrimaryGreen),
                Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('Patient Name: John Doe\nPatient ID: P002/3',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'PT Serif',
                        )))
              ]),
            ),
            bottom: TabBar(
              indicatorColor: kPrimaryGreen,
              indicatorWeight: 5.0,
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                    child: tabitem(
                  label: "Overview",
                  path: MyCustomIcons.history_clock_button,
                )),
                Tab(
                    child: tabitem(
                  label: "Diagnosis",
                  path: MyCustomIcons.health_report,
                )),
                Tab(
                    child: tabitem(
                  label: "Treatment",
                  path: MyCustomIcons.pill,
                )),
                Tab(
                    child: tabitem(
                  label: "Updates",
                  path: MyCustomIcons.email,
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              OverviewTab(),
              DiagnosisTab(),
              TreatmentTab(),
              MyUpdatesTab(),
            ],
          )),
    );
  }
}

Widget tabitem({label, path}) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontFamily: 'PT Serif',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        Padding(
            padding: EdgeInsets.only(left: 3),
            child: Icon(
              path,
              size: 15,
              color: Colors.black,
            ))
      ],
    ),
  );
}
