import 'package:Tabibu/app/auth/signin.dart';
import 'package:Tabibu/app/screens/medicalhistory.dart';
import 'package:Tabibu/app/screens/medicalupdate.dart';
import 'package:Tabibu/app/screens/mydoctors.dart';
import 'package:Tabibu/app/screens/profile.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class PatientDashboard extends StatelessWidget {
  static const routeName = "/patientdashboard";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 56,
          backgroundColor: kPrimaryAccent,
          actions: [
            new IconButton(
              icon: Icon(Icons.circle_notifications),
              color: kPrimaryGreen,
              padding: EdgeInsets.only(top: 14, right: 24.49),
              iconSize: 30,
              onPressed: () {},
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              new Container(
                color: kPrimaryAccent,
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 22),
                              child: Text('John Doe',
                                  style: TextStyle(
                                      color: kPrimaryGreen,
                                      fontFamily: 'Source Sans',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: kPrimaryAccent,
                padding: const EdgeInsets.only(left: 24, bottom: 270, top: 50),
                child: Column(
                  children: [
                    ListTile(
                      title: new Text('Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PT Serif',
                              fontSize: 22,
                              fontWeight: FontWeight.w700)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: new Text('About',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PT Serif',
                              fontSize: 22,
                              fontWeight: FontWeight.w700)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: new Text('Sign Out',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PT Serif',
                              fontSize: 22,
                              fontWeight: FontWeight.w700)),
                      onTap: () {
                        Navigator.of(context).pushNamed(SignIn.routeName);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 160, right: 110),
                      child: Text(
                        "Terms & Conditions\nPrivacy Policy\nTabibu Limited © 2021",
                        style: TextStyle(
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: kPrimaryGreen),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('Welcome to Tabibu John Doe',
                        style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w700,
                            color: Colors.black))),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: kPrimaryYellow,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('assets/images/pulse.png'),
                                width: 55,
                                height: 55,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('',
                                      style: TextStyle(
                                          fontFamily: 'Source Sans',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)))
                            ],
                          ),
                        ))),
                Text(
                  'What do you need?',
                  style: TextStyle(
                      fontFamily: 'Source Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Row(children: [
                        dashcard(
                            redirect: MedicalHistory.routeName,
                            path: MyCustomIcons.history_clock_button,
                            label: "View Medical History"),
                        dashcard(
                            redirect: MedicalUpdate.routeName,
                            path: MyCustomIcons.email,
                            label: "Send Medical Update"),
                        dashcard(
                            redirect: MyDoctors.routeName,
                            path: MyCustomIcons.calendar,
                            label: "Book Appointment"),
                      ]),
                      Container(
                          color: kPrimaryAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                navitem(
                                  navlabel: "Home",
                                  navpath: MyCustomIcons.home,
                                  navredirect: null,
                                ),
                                navitem(
                                  navlabel: "My Doctors",
                                  navpath: MyCustomIcons.doctor,
                                  navredirect: MyDoctors.routeName,
                                ),
                                navitem(
                                  navlabel: "Profile",
                                  navpath: MyCustomIcons.profile_user,
                                  navredirect: Profile.routeName,
                                ),
                              ]))
                    ],
                  ),
                )
              ]),
        ));
  }
}

Widget dashcard({label, path, redirect}) {
  return Card(
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color: Colors.white,
    child: Material(
        child: InkWell(
            onTap: () {
              BuildContext context;
              Navigator.of(context).pushNamed(redirect);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      path,
                      size: 35,
                      color: kPrimaryGreen,
                    )), // icon
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    label,
                    style: TextStyle(
                        fontFamily: 'PT Serif',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.black.withOpacity(1.0)),
                  ),
                ), // text
              ],
            ))),
  );
}

Widget navitem({navlabel, navpath, navredirect}) {
  bool isSelected = false;
  return Material(
      child: InkWell(
          onTap: () {
            BuildContext context;
            Navigator.of(context).pushNamed(navredirect);
          },
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(
                    navpath,
                    size: 35,
                    color: isSelected ? kPrimaryGreen : Colors.black,
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    navlabel,
                    style: TextStyle(
                      fontFamily: 'PT Serif',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? kPrimaryGreen : Colors.black,
                    ),
                  ))
            ],
          )));
}
