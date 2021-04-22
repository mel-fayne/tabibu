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
import 'package:Tabibu/app/screens/doctors/patientupdates.dart';
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
        DoctorDetails.routeName: (ctx) => DoctorDetails(),
        PatientDetails.routeName: (ctx) => PatientDetails(),
        DoctorDashboard.routeName: (ctx) => DoctorDashboard(),
        PatientDashboard.routeName: (ctx) => PatientDashboard(),
        MedicalHistory.routeName: (ctx) => MedicalHistory(),
        MyDoctors.routeName: (ctx) => MyDoctors(),
        PatientProfile.routeName: (ctx) => PatientProfile(),
        DoctorProfile.routeName: (ctx) => DoctorProfile(),
        MyPatients.routeName: (ctx) => MyPatients(),
        NewRecord.routeName: (ctx) => NewRecord(),
        PatientUpdates.routeName: (ctx) => PatientUpdates(),
        OverviewTab.routeName: (ctx) => OverviewTab(),
        DiagnosisTab.routeName: (ctx) => DiagnosisTab(),
        TreatmentTab.routeName: (ctx) => TreatmentTab(),
        MyUpdatesTab.routeName: (ctx) => MyUpdatesTab(),
        //  SingleDiagnosis.routeName: (ctx) => SingleDiagnosis(),
        SingleUpdate.routeName: (ctx) => SingleUpdate(),
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
