import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

class MyPatients extends StatefulWidget {
  static const routeName = "/mypatients";

  @override
  _MyPatientsState createState() => _MyPatientsState();
}

class _MyPatientsState extends State<MyPatients> {
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
                  "View Patients",
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
          Padding(
              padding: EdgeInsets.only(left: 3),
              child: Text(
                'My Patients',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Source Sans',
                  fontWeight: FontWeight.w600,
                ),
              )),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("imagepath"),
            ),
            title: Text("Patient Name: ...",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Source Sans',
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            subtitle: Column(
              children: [
                Text("Name of Condition: ...",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Text("Status: ...",
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
        ]),
      ),
    );
  }
}

/*
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
*/
