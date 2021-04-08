import 'package:Tabibu/app/screens/bookappointment.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class SingleDoctor extends StatefulWidget {
  static const routeName = "/singledoctor";

  @override
  _SingleDoctorState createState() => _SingleDoctorState();
}

class _SingleDoctorState extends State<SingleDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 20),
              child: Row(children: [
                Icon(MyCustomIcons.profile_user,
                    size: 30, color: kPrimaryGreen),
                Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                        'Doctor Name: Dr.Jules Rue   Doctor ID: D002/3\nDr.License: DN2385',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'PT Serif',
                        )))
              ]),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Specialty: Psychologist   Base Hospital: Aga Khan Hospital\nStatus:Available   Years of Practise:5years',
                  style: TextStyle(
                    color: kFieldTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'PT Serif',
                  ),
                )),
            Container(
                decoration: BoxDecoration(
                  color: kPrimaryYellow,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(children: [
                      Text('Stats',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Card(
                              elevation: 4,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.pie_chart,
                                      color: kPrimaryGreen,
                                      size: 56,
                                    ),
                                    Text(
                                        '1. Helathy Patients\n2. Diagnosed Patients\n 3. Patients on Treatment',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Source Sans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                  ]))),
                      Text('About',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                                title: Text(
                                    'Dr. Jules Rue is a well respected psychologist and mental helath specialist at Aga Khan Hospital. She is reknown for her patient care through out all her patients journey.',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Source Sans',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      MyCustomIcons.calendar,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    Text(
                                      'Monday - Friday\n0900h - 1700h',
                                      style: TextStyle(
                                          color: kFieldTextColor,
                                          fontFamily: 'Source Sans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )),
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 40,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(BookAppointment.routeName);
                          },
                          color: kPrimaryGreen,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text("MAKE APPOINTMENT",
                              style: TextStyle(
                                  color: kPrimaryYellow,
                                  fontFamily: 'PT Serif',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ]))),
          ])),
    );
  }
}
