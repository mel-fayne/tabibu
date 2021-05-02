import 'package:Tabibu/app/models/diagnosis.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/newupdate.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyUpdatesTab extends StatefulWidget {
  static const routeName = "/myupdatestab";

//accepting parameters from previous screen
  final String ptid;
  MyUpdatesTab({@required this.ptid});
  @override
  State<StatefulWidget> createState() {
    return MyUpdatesTabState(this.ptid);
  }
}

class MyUpdatesTabState extends State<MyUpdatesTab> {
  String ptid;
  MyUpdatesTabState(this.ptid);

  // ignore: missing_return
  Future<List<Diagnosis>> fetchDiagnosis() async {
    var url = "http://192.168.0.15/tabibu/api/updates/getupdates.php";
    var res = await http.post(url, body: {"patientid": ptid});
    var update = json.decode(res.body);
    if (update == "error") {
      print('Unexpected error occured!');
    } else {
      List jsonResponse = update;
   //   return jsonResponse.map((data) => new Diagnosis.fromJson(data)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Medical Updates',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PT Serif',
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    ),
                  ],
                )),
            FutureBuilder<List<Diagnosis>>(
              future: fetchDiagnosis(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Diagnosis> data = snapshot.data;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Icon(
                            MyCustomIcons.health_report,
                            color: kPrimaryGreen,
                            size: 55,
                          ),
                          title: Text("Date: $data[index].date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Source Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          subtitle: Column(
                            children: [
                              Text("How you felt: $data[index].feel",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Source Sans',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black))
                            ],
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: kPrimaryGreen,
                            size: 30,
                          ),
                          onTap: () {
                            debugPrint("ListTile Tapped");
                            /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SingleDiagnosis(
                                    this.$data[index]),
                          )); */
                          },
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return CircularProgressIndicator(
                  backgroundColor: kPrimaryGreen,
                );
              },
            )
          ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryGreen,
        elevation: 4,
        onPressed: () {
          Navigator.of(context).pushNamed(NewUpdate.routeName);
        },
        child: Icon(
          Icons.add,
          size: 45,
          color: kPrimaryYellow,
        ),
      ),
    );
  }
}
