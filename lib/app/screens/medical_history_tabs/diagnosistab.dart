import 'package:flutter/material.dart';
import 'package:Tabibu/app/screens/doctors/newrecord.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';

class DiagnosisTab extends StatefulWidget {
  static const routeName = "/diagnosistab";

  @override
  _DiagnosisTabState createState() => _DiagnosisTabState();
}

class _DiagnosisTabState extends State<DiagnosisTab> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getDiagnosisListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryGreen,
        elevation: 4,
        tooltip: 'Add New Medical Record',
        onPressed: () {
          Navigator.of(context).pushNamed(NewRecord.routeName);
        },
        child: Icon(
          Icons.add,
          size: 45,
          color: kPrimaryYellow,
        ),
      ),
    );
  }

  ListView getDiagnosisListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: Icon(
              MyCustomIcons.health_report,
              color: kPrimaryGreen,
              size: 55,
            ),
            title: Text(
                //this.diagnosisList[position].disease,
                '',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Source Sans',
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            subtitle: Column(
              children: [
                Text(
                    //  this.diagnosisList[position].description,
                    '',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                        //this.diagnosisList[position].diagnosisdate,
                        '',
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
    );
  }
}
