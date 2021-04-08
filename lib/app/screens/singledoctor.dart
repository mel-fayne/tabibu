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
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Container(
          padding: EdgeInsets.only(top: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 50, bottom: 10),
              child: Row(children: [
                Icon(MyCustomIcons.profile_user,
                    size: 50, color: kPrimaryGreen),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                        'Name: Dr.Jules Rue\nDoctor ID: D002/3\nDr.License: DN2385',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'PT Serif',
                        )))
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, bottom: 40),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Specialty: Psychologist\nBase Hospital: Aga Khan Hospital',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'PT Serif',
                      ),
                    ),
                    Text(
                      'Status:Available\nYears of Practise:5years',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'PT Serif',
                      ),
                    )
                  ]),
            ),
            Container(
                decoration: BoxDecoration(
                  color: kPrimaryYellow,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Padding(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Stats',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Source Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Card(
                                  color: kPrimaryAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 4,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 25),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.pie_chart,
                                              color: kPrimaryGreen,
                                              size: 66,
                                            ),
                                            Text(
                                                '1. Helathy Patients\n2. Diagnosed Patients\n 3. Patients on Treatment',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Source Sans',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ])))),
                          Text('About',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Source Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Card(
                                  color: kPrimaryAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 4,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 25),
                                    child: ListTile(
                                        title: Text(
                                            'Dr. Jules Rue is a well respected psychologist and mental helath specialist at Aga Khan Hospital. She is reknown for her patient care through out all her patients journey.',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Source Sans',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black)),
                                        subtitle: Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 100),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  MyCustomIcons.calendar,
                                                  color: Colors.black,
                                                  size: 30,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      'Monday - Friday\n0900h - 1700h',
                                                      style: TextStyle(
                                                          color:
                                                              kFieldTextColor,
                                                          fontFamily:
                                                              'Source Sans',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))
                                              ],
                                            ))),
                                  ))),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 35),
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
