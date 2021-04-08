import 'package:Tabibu/app/screens/medical_history_tabs/medicalhistory.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class MyPatients extends StatelessWidget {
  static const routeName = "/mypatients";
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
                      padding: EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Patients",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'PT Serif',
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      )),
          Padding(
              padding: EdgeInsets.only(bottom: 15, left: 15, right: 35),
              child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  decoration: BoxDecoration(
                    color: kGreyBackground,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                      decoration: InputDecoration(
                    hintText: 'Search patients',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  )))),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(MedicalHistory.routeName);
              },
              child: ListTile(
                leading: Icon(MyCustomIcons.profile_user,
                    size: 30, color: kPrimaryGreen),
                title: Text('Name: John Doe\nCondition: Depression',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                subtitle: Text(
                    "Status: On Treatment\nHospital: Aga Khan Hospital",
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
                leading: Icon(MyCustomIcons.profile_user,
                    size: 30, color: kPrimaryGreen),
                title: Text('Name: Rita Mambo\nCondition: Pregnant',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                subtitle: Text(
                    "Status: 6 months\nHospital: Nairobi Women's Hospital",
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
                leading: Icon(MyCustomIcons.profile_user,
                    size: 30, color: kPrimaryGreen),
                title: Text('Name: Hudson Tisha\nCondition: Colon Cancer',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                subtitle: Text(
                    "Status: Stage 4\nHospital: Kenyatta National Hospital",
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
        ]),
      ),
    );
  }
}
