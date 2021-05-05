import 'package:Tabibu/app/auth/doctordetails.dart';
import 'package:Tabibu/app/auth/forgotpassword.dart';
import 'package:Tabibu/app/auth/patientdetails.dart';
import 'package:Tabibu/app/auth/signin.dart';
import 'package:Tabibu/app/auth/signup.dart';
import 'package:Tabibu/app/screens/bookappointment.dart';
import 'package:Tabibu/app/screens/doctors/doctordashboard.dart';
import 'package:Tabibu/app/screens/doctors/doctorprofile.dart';
import 'package:Tabibu/app/screens/doctors/mypatients.dart';
import 'package:Tabibu/app/screens/doctors/newrecord.dart';
import 'package:Tabibu/app/screens/doctors/schedulelist.dart';
import 'package:Tabibu/app/screens/doctors/singleappointment.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/diagnosistab.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/medicalhistory.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/newupdate.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/overviewtab.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/singleupdate.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/treatmenttab.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/myupdatestab.dart';
import 'package:Tabibu/app/screens/mydoctors.dart';
import 'package:Tabibu/app/screens/notifications.dart';
import 'package:Tabibu/app/screens/singledoctor.dart';
import 'package:Tabibu/app/screens/patientdashboard.dart';
import 'package:Tabibu/app/screens/patientprofile.dart';
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
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        SignIn.routeName: (ctx) => SignIn(),
        ForgotPassword.routeName: (ctx) => ForgotPassword(),
        SignUp.routeName: (ctx) => SignUp(),
        DoctorDetails.routeName: (ctx) => DoctorDetails(
              fullname: null,
              userid: null,
            ),
        PatientDetails.routeName: (ctx) => PatientDetails(
              fullname: null,
              userid: null,
            ),
        DoctorDashboard.routeName: (ctx) => DoctorDashboard(
              fullname: null,
              userid: null,
              drid: null,
            ),
        PatientDashboard.routeName: (ctx) => PatientDashboard(
              fullname: null,
              userid: null,
              ptid: null,
            ),
        MedicalHistory.routeName: (ctx) => MedicalHistory(
              ptid: null,
              fullname: null,
            ),
        MyDoctors.routeName: (ctx) => MyDoctors(),
        PatientProfile.routeName: (ctx) => PatientProfile(
              userid: null,
            ),
        DoctorProfile.routeName: (ctx) => DoctorProfile(userid: null),
        MyPatients.routeName: (ctx) => MyPatients(),
        NewRecord.routeName: (ctx) => NewRecord(),
        ScheduleList.routeName: (ctx) => ScheduleList(),
        OverviewTab.routeName: (ctx) => OverviewTab(
              ptid: null,
            ),
        DiagnosisTab.routeName: (ctx) => DiagnosisTab(
              ptid: null,
            ),
        TreatmentTab.routeName: (ctx) => TreatmentTab(
              ptid: null,
            ),
        MyUpdatesTab.routeName: (ctx) => MyUpdatesTab(
              ptid: null,
            ),
        //  SingleDiagnosis.routeName: (ctx) => SingleDiagnosis(),
        SingleUpdate.routeName: (ctx) => SingleUpdate(
              updid: null,
            ),
        NewUpdate.routeName: (ctx) => NewUpdate(),
        SingleDoctor.routeName: (ctx) => SingleDoctor(),
        BookAppointment.routeName: (ctx) => BookAppointment(),
        SingleAppointment.routeName: (ctx) => SingleAppointment(),
        Notifications.routeName: (ctx) => Notifications(),
      },
      home: SignIn(),
    );
  }
}
