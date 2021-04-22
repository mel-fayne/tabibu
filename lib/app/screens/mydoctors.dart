import 'package:Tabibu/app/screens/singledoctor.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class MyDoctors extends StatefulWidget {
  static const routeName = "/mydoctors";

  @override
  _MyDoctorsState createState() => _MyDoctorsState();
}

class _MyDoctorsState extends State<MyDoctors> {
  TextEditingController searchctrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Doctors",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'PT Serif',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: TextField(
              cursorColor: kPrimaryGreen,
              controller: searchctrl,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Source Sans',
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              onChanged: (value) {
                debugPrint('something changed in this feld');
                //  diagnosis.patientid = patientidController.text as int;
              },
              decoration: InputDecoration(
                  labelText: "Search Doctors",
                  labelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w400,
                      color: kFieldTextColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(SingleDoctor.routeName);
              },
              child: ListTile(
                leading: Icon(MyCustomIcons.profile_user,
                    size: 30, color: kPrimaryGreen),
                title: Text('Name: Dr. Jules Rue\nDoctor ID: D002/2',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                subtitle: Text(
                    "Speciality: Psychologist\nHospital: Aga Khan Hospital",
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
                title: Text('Name: Dr. Matthew Roberts\nDoctor ID: D003/3',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                subtitle: Text(
                    "Speciality: General Doctor\nHospital: Kenyatta National Hospital",
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
                title: Text('Name: Dr. Keneddy Mutua\nDoctor ID: D016/6',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                subtitle: Text(
                    "Speciality: Physician\nHospital: M-pisha Hospital",
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
