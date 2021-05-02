import 'package:Tabibu/app/screens/medical_history_tabs/diagnosistab.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/myupdatestab.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/overviewtab.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/treatmenttab.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class MedicalHistory extends StatefulWidget {
  static const routeName = "/medicalhistory";

  //accepting parameters from previous screen
  final String ptid;
  final String fullname;
  MedicalHistory({@required this.ptid, @required this.fullname});
  @override
  State<StatefulWidget> createState() {
    return MedicalHistoryState(this.ptid, this.fullname);
  }
}

class MedicalHistoryState extends State<MedicalHistory> {
  String ptid;
  String fullname;
  MedicalHistoryState(this.ptid, this.fullname);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 130,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(children: [
                Row(
                  children: [
                    Icon(MyCustomIcons.profile_user,
                        size: 40, color: kPrimaryGreen),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: textProfile(
                              label: "Patient Name:",
                              text: "$fullname",
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: textProfile(
                              label: "Patient ID:",
                              text: "$ptid",
                            ))
                      ],
                    ),
                  ],
                ),
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
              OverviewTab(ptid: ptid),
              DiagnosisTab(ptid: ptid),
              TreatmentTab(ptid: ptid),
              MyUpdatesTab(ptid: ptid),
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

Widget textProfile({label, text}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        Text(label,
            style: TextStyle(
              color: kFieldTextColor,
              fontSize: 12,
              fontFamily: 'PT Serif',
              fontWeight: FontWeight.w600,
            )),
        Padding(
            padding: EdgeInsets.only(left: 5),
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
