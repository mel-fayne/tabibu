import 'package:Tabibu/app/screens/medical_history_tabs/newupdate.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/singleupdate.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class MyUpdatesTab extends StatefulWidget {
  static const routeName = "/myupdatestab";

  @override
  _MyUpdatesTabState createState() => _MyUpdatesTabState();
}

class _MyUpdatesTabState extends State<MyUpdatesTab> {
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
                        'Updates (2)',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'PT Serif',
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                      FloatingActionButton(
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
                    ],
                  )),
              Container(
                  width: double.infinity,
                  child: Column(children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SingleUpdate.routeName);
                        },
                        child: ListTile(
                          leading: Icon(
                            MyCustomIcons.health_report,
                            color: kPrimaryGreen,
                            size: 55,
                          ),
                          title: Text('Update Two',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Source Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          subtitle: Text("Date: 15/03/2021",
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
                          title: Text('Update One',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Source Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          subtitle: Text("Date: 22/02/2021",
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
                  ])),
            ])));
  }
}
