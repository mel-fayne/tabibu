import 'package:Tabibu/app/auth/doctordetails.dart';
import 'package:Tabibu/app/auth/forgotpassword.dart';
import 'package:Tabibu/app/auth/patientdetails.dart';
import 'package:Tabibu/app/auth/signin.dart';
import 'package:Tabibu/app/auth/signup.dart';
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
      },
      home: SignIn(),
    );
  }
}
