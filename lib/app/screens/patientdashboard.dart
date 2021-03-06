import 'package:Tabibu/app/auth/signin.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/medicalhistory.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/newupdate.dart';
import 'package:Tabibu/app/screens/mydoctors.dart';
import 'package:Tabibu/app/screens/patientprofile.dart';
import 'package:Tabibu/app/screens/ptappt.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class PatientDashboard extends StatefulWidget {
  static const routeName = "/doctordashboard";

  //accepting parameters from previous screen
  final String fullname;
  final String userid;
  final String ptid;
  PatientDashboard(
      {@required this.fullname, @required this.userid, @required this.ptid});
  @override
  State<StatefulWidget> createState() {
    return PatientDashboardState(this.fullname, this.userid, this.ptid);
  }
}

class PatientDashboardState extends State<PatientDashboard> {
  String fullname;
  String userid;
  String ptid;
  PatientDashboardState(this.fullname, this.userid, this.ptid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 56,
          backgroundColor: kPrimaryAccent,
          actions: [
            new IconButton(
              icon: Icon(Icons.calendar_today),
              color: kPrimaryGreen,
              padding: EdgeInsets.only(top: 14, right: 24.49),
              iconSize: 27,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PtScheduleList(ptid: ptid),
                    ));
              },
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
                              child: Text('$fullname',
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PatientProfile(userid: userid),
                            ));
                      },
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
                        "Terms & Conditions\nPrivacy Policy\nTabibu Limited ?? 2021",
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
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('Welcome to Tabibu $fullname',
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
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('assets/images/pulse.png'),
                                width: 55,
                                height: 55,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                      'Oh no!????Not a third wave????Let us adhere to\nMOH guidelines and we will overcome this.\nWear your mask???? and remember to sanitise????',
                                      style: TextStyle(
                                          fontFamily: 'Source Sans',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)))
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
                        Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, bottom: 20),
                            child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.white,
                                child: Material(
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MedicalHistory(
                                                        ptid: ptid,
                                                        fullname: fullname),
                                              ));
                                        },
                                        child: dashcard(
                                            path: MyCustomIcons
                                                .history_clock_button,
                                            label: "View Medical History"))))),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, bottom: 20),
                            child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.white,
                                child: Material(
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NewUpdate(ptid: ptid),
                                              ));
                                        },
                                        child: dashcard(
                                            path: MyCustomIcons.email,
                                            label: "Send Medical Update"))))),
                      ]),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, bottom: 20),
                          child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: Material(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyDoctors(ptid: ptid),
                                            ));
                                      },
                                      child: dashcard(
                                          path: MyCustomIcons.calendar,
                                          label: "Book Appointment"))))),
                      Container(
                        padding: EdgeInsets.only(bottom: 40),
                      ),
                      Container(
                          alignment: FractionalOffset.bottomCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: kPrimaryAccent,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Material(
                                    color: kPrimaryAccent,
                                    child: InkWell(
                                        onTap: () {},
                                        child: navitem(
                                          navlabel: "Home",
                                          navpath: MyCustomIcons.home,
                                        ))),
                                Material(
                                    color: kPrimaryAccent,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MyDoctors(ptid: ptid),
                                              ));
                                        },
                                        child: navitem(
                                          navlabel: "My Doctors",
                                          navpath: MyCustomIcons.doctor,
                                        ))),
                                Material(
                                    color: kPrimaryAccent,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PatientProfile(
                                                        userid: userid),
                                              ));
                                        },
                                        child: navitem(
                                          navlabel: "Profile",
                                          navpath: MyCustomIcons.profile_user,
                                        ))),
                              ]))
                    ],
                  ),
                )
              ]),
        ));
  }
}

Widget dashcard({label, path}) {
  return Padding(
      padding: EdgeInsets.all(10),
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
      ));
}

Widget navitem({navlabel, navpath}) {
  bool isSelected = false;
  return Column(
    children: [
      Padding(
          padding: EdgeInsets.only(top: 10),
          child: Icon(
            navpath,
            size: 25,
            color: isSelected ? kPrimaryGreen : Colors.black,
          )),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
  );
}
