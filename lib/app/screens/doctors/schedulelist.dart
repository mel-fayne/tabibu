import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

class ScheduleList extends StatelessWidget {
  static const routeName = "/schedulelist";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 56,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "View Patient Updates & Appointments",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'PT Serif',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              )),
          ListTile(
            leading: Icon(
              Icons.schedule,
              color: kPrimaryGreen,
              size: 35,
            ),
            title: Text(
                "Patient Name: ...\nLocation: ...  Date: ...  Time: ...",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Source Sans',
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            subtitle: Text("Appointment Reason: ...",
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
            onTap: () {
              debugPrint("ListTile Tapped");
              //  navigateToDetail(this.diagnosisList[position]);
            },
          ),
        ]),
      ),
    );
  }
}

/*
GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(SingleAppointment.routeName);
              },
              child: ListTile(
                leading: Icon(MyCustomIcons.profile_user,
                    size: 40, color: kPrimaryGreen),
                title: Text('John Doe\nType: Appointment',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                subtitle: Text("Date: 23/04.2021\nNew Patient Request",
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
              onTap: () {
                Navigator.of(context).pushNamed(SingleUpdate.routeName);
              },
              child: ListTile(
                leading: Icon(MyCustomIcons.profile_user,
                    size: 40, color: kPrimaryGreen),
                title: Text('Rita Mambo\nType: Medical Update',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                subtitle: Text("Date: 15/03.2021\nPregnancy Check Up",
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
*/
