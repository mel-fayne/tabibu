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
                      'My Medical Updates',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PT Serif',
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    ),
                  ],
                )),
            ListTile(
              leading: Icon(
                MyCustomIcons.health_report,
                color: kPrimaryGreen,
                size: 55,
              ),
              title: Text('Date: ...',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              trailing: Icon(
                Icons.keyboard_arrow_right_outlined,
                color: kPrimaryGreen,
                size: 34,
              ),
            ),
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
