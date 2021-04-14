import 'package:Tabibu/app/models/diagnosis.dart';
import 'package:Tabibu/app/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:Tabibu/app/screens/doctors/newrecord.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/singlediagnosis.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:sqflite/sqflite.dart';

class DiagnosisTab extends StatefulWidget {
  static const routeName = "/diagnosistab";

  @override
  _DiagnosisTabState createState() => _DiagnosisTabState();
}

class _DiagnosisTabState extends State<DiagnosisTab> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Diagnosis> diagnosisList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (diagnosisList == null) {
      //if list is null instantiate it
      diagnosisList = List<Diagnosis>();
      updateListView();
    }

    return Scaffold(
      body: getDiagnosisListView(),
      /* Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Diagnosis (3)',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PT Serif',
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    )
                  ],
                )),
            Container(
              // width: double.infinity,
              child: getDiagnosisListView(),
              //Column(children: [

              /* GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(SingleDiagnosis.routeName);
                      },
                      child: ListTile(
                        leading: Icon(
                          MyCustomIcons.health_report,
                          color: kPrimaryGreen,
                          size: 55,
                        ),
                        title: Text('Diagnosis: Depression',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        subtitle: Text(
                            "We noted an improvement in John's drinking habits. He has a more postive outlook and the treatment is taking effect as expected.\n Date: 03/03/2021",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: kFieldTextColor)),
                        trailing: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: kPrimaryGreen,
                          size: 34,
                        ),
                      )),
                  GestureDetector(
                      onTap: () {},
                      child: ListTile(
                        leading: Icon(
                          MyCustomIcons.health_report,
                          color: kPrimaryGreen,
                          size: 55,
                        ),
                        title: Text('Diagnosis: Depression',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        subtitle: Text(
                            "We noted an improvement in John's drinking habits. He has a more postive outlook and the treatment is taking effect as expected.\n Date: 23/02/2021",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: kFieldTextColor)),
                        trailing: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: kPrimaryGreen,
                          size: 34,
                        ),
                      )),
                  GestureDetector(
                      onTap: () {},
                      child: ListTile(
                        leading: Icon(
                          MyCustomIcons.health_report,
                          color: kPrimaryGreen,
                          size: 55,
                        ),
                        title: Text('Diagnosis: Anxiety',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        subtitle: Text(
                            "We noted an improvement in John's drinking habits. He has a more postive outlook and the treatment is taking effect as expected.\n Date: 17/01/2021",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: kFieldTextColor)),
                        trailing: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: kPrimaryGreen,
                          size: 34,
                        ),
                      ))
                ]) */
            )
          ])),
       */
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
            title: Text(this.diagnosisList[position].disease,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Source Sans',
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            subtitle: Column(
              children: [
                Text(this.diagnosisList[position].description,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(this.diagnosisList[position].diagnosisdate,
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
              navigateToDetail(this.diagnosisList[position]);
            },
          ),
        );
      },
    );
  }

  /*  void _delete(BuildContext context, Diagnosis diagnosis) async {
    int result = await databaseHelper.deleteDiagnosis(diagnosis.patientid);
    if (result != 0) {
      Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.white),
        message: '',
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 75, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryYellow,
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    }
  } */

  void navigateToDetail(Diagnosis diagnosis) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SingleDiagnosis(diagnosis);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Diagnosis>> diagnosisListFuture =
          databaseHelper.getDiagnosisList();
      diagnosisListFuture.then((diagnosisList) {
        setState(() {
          this.diagnosisList = diagnosisList;
          this.count = diagnosisList.length;
        });
      });
    });
  }
}
