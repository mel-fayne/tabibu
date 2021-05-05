import 'package:Tabibu/app/models/update.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/newupdate.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/singleupdate.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
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
  String updateid;
  MyUpdatesTabState(this.ptid);

  @override
  void initState() {
    super.initState();
    getUpdateList();
  }

  List<Update> updatedata = [];

  getUpdateList() async {
    var url = "http://192.168.0.15/tabibu/api/updates/getupdates.php";
    var res = await http.post(url, body: {"patientid": ptid});
    var update = json.decode(res.body);
    if (update == "no update") {
      print('Unexpected error occured!');
    } else {
      for (var data in update) {
        updatedata.add(new Update(
          data['updateid'],
          data['patientid'],
          data['doctorid'],
          data['date'],
          data['feel'],
          data['partache'],
          data['painrate'],
          data['newsymptom'],
          data['sideeffect'],
          data['medintake'],
          data['additional'],
        ));
      }
      setState(() {});
      updatedata.forEach((someData) => print("Name : ${someData.updateid}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: updatedata.length == 0
            ? Center(
                child: Text('You have no updates yet!',
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
                    itemCount: updatedata.length,
                    itemBuilder: (_, index) {
                      return Card(
                          color: Colors.pink[100],
                          elevation: 7.0,
                          child: ListTile(
                            leading: Icon(
                              Icons.update,
                              color: kPrimaryGreen,
                              size: 45,
                            ),
                            title: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: textProfile(
                                label: 'Date:',
                                text: '${updatedata[index].date}',
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: textProfile(
                                label: 'How you felt:',
                                text: '${updatedata[index].feel}',
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_right_outlined,
                              color: kPrimaryGreen,
                              size: 25,
                            ),
                            onTap: () {
                              updateid = updatedata[index].updateid;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SingleUpdate(updid: updateid)));
                            },
                          ));
                    })),
      ),
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
