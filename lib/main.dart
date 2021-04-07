import 'package:Tabibu/app/auth/doctordetails.dart';
import 'package:Tabibu/app/auth/forgotpassword.dart';
import 'package:Tabibu/app/auth/patientdetails.dart';
import 'package:Tabibu/app/auth/signin.dart';
import 'package:Tabibu/app/auth/signup.dart';
import 'package:Tabibu/app/screens/doctors/doctordashboard.dart';
import 'package:Tabibu/app/screens/doctors/mypatients.dart';
import 'package:Tabibu/app/screens/doctors/myupdates.dart';
import 'package:Tabibu/app/screens/doctors/newrecord.dart';
import 'package:Tabibu/app/screens/medicalhistory.dart';
import 'package:Tabibu/app/screens/medicalupdate.dart';
import 'package:Tabibu/app/screens/mydoctors.dart';
import 'package:Tabibu/app/screens/patientdashboard.dart';
import 'package:Tabibu/app/screens/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        SignIn.routeName: (ctx) => SignIn(),
        ForgotPassword.routeName: (ctx) => ForgotPassword(),
        SignUp.routeName: (ctx) => SignUp(),
        DoctorDetails.routeName: (ctx) => DoctorDetails(),
        PatientDetails.routeName: (ctx) => PatientDetails(),
        DoctorDashboard.routeName: (ctx) => DoctorDashboard(),
        PatientDashboard.routeName: (ctx) => PatientDashboard(),
        MedicalHistory.routeName: (ctx) => MedicalHistory(),
        MedicalUpdate.routeName: (ctx) => MedicalUpdate(),
        MyDoctors.routeName: (ctx) => MyDoctors(),
        Profile.routeName: (ctx) => Profile(),
        MyPatients.routeName: (ctx) => MyPatients(),
        NewRecord.routeName: (ctx) => NewRecord(),
        MyUpdates.routeName: (ctx) => MyUpdates(),
      },
      home: SignIn(),
    );
  }
}
