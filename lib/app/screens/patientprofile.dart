import 'package:Tabibu/app/auth/patientdetails.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

class PatientProfile extends StatefulWidget {
  static const routeName = "/patientprofile";

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
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
          padding: EdgeInsets.only(top: 20, left: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'My Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'PT Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'User Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.person,
                            color: kPrimaryGreen,
                            size: 16,
                          ))
                    ],
                  ),
                  Text(
                    'Name: ...  Email Adress: ....\nResidence County: ...  Mobile Number: ...\nPatient ID: ...',
                    style: TextStyle(
                      color: kFieldTextColor,
                      fontSize: 14,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Patient Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.medical_services,
                            color: kPrimaryGreen,
                            size: 16,
                          ))
                    ],
                  ),
                  Text(
                    'Date of Birth: ...\nType of Condition: ...\n Name of Condition: ...\nBlood Type: ...\nMode of Medical Payments: ...',
                    style: TextStyle(
                      color: kFieldTextColor,
                      fontSize: 14,
                      fontFamily: 'Source Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 40,
                      onPressed: () {
                        setState(() {
                          debugPrint("Button clicked..");
                        });
                        Navigator.of(context)
                            .pushNamed(PatientDetails.routeName);
                      },
                      color: kPrimaryGreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("FINISH ACCOUNT SETUP",
                          style: TextStyle(
                              color: kPrimaryYellow,
                              fontFamily: 'PT Serif',
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
