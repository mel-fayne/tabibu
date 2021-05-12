import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class BookAppointment extends StatefulWidget {
  static const routeName = "/bookappointment";

  //accepting parameters from previous screen
  final String name;
  final String hospital;
  final String docid;
  final String ptid;
  final String days;
  final String time;
  BookAppointment(
      {@required this.hospital,
      @required this.name,
      @required this.docid,
      @required this.ptid,
      @required this.days,
      @required this.time});
  @override
  State<StatefulWidget> createState() {
    return BookAppointmentState(
        this.hospital, this.name, this.docid, this.ptid, this.days, this.time);
  }
}

class BookAppointmentState extends State<BookAppointment> {
  String name;
  String hospital;
  String docid;
  String ptid;
  String days;
  String time;

  BookAppointmentState(
      this.hospital, this.name, this.docid, this.ptid, this.days, this.time);

  DateTime selectedDate = DateTime.now();
  String formattedDate;

  TextEditingController reasonctrl;

  final _formKey = GlobalKey<FormState>();

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reasonctrl = new TextEditingController();
  }

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
  }

  Future bookAppointment() async {
    setState(() {});
    var url =
        "http://192.168.0.15/tabibu/api/appointments/postappointments.php";
    var data = {
      "patientid": ptid,
      "doctorid": docid,
      "date": formattedDate,
      "location": hospital,
      "reason": reasonctrl.text,
    };

    var res = await http.post(url, body: data);
    var appt = jsonDecode(res.body);

    if (appt == "error") {
      print("error");
      return Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "An error occured! Try again later",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    } else {
      print("Yoooo! It worked!");
      print(formattedDate);
      return Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message:
            "Your appointment request has been sent! The doctor will send a confirmation with the appointment time.",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 7),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
      //
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(MyCustomIcons.profile_user,
                        size: 90, color: kPrimaryGreen),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('Dr. $name',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'PT Serif',
                            ))),
                    textProfile(label: "Location:", text: "$hospital"),
                  ]),
            ),
            Text(
              'Dr. $name is only available on $days at $time.',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'PT Serif',
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Select the day of the appointment:',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Source Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                )),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  RaisedButton(
                    onPressed: () => selectDate(context),
                    child: Text(
                      'Select the day of the appointment:',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    color: kPrimaryAccent,
                  ),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 20, bottom: 10),
                child: makeInput(
                  label: "Reason for Appointment",
                  controller: reasonctrl,
                )),
            Text(
              "By clicking the book appointment button, you agree to allow Dr.$name to view your previous medical reports and add to your medical history",
              style: TextStyle(
                  color: kFieldTextColor,
                  fontFamily: 'PT Serif',
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: processing
                  ? CircularProgressIndicator()
                  : MaterialButton(
                      minWidth: double.infinity,
                      height: 40,
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            processing = true;
                            debugPrint("Book Appointment button clicked");
                            bookAppointment();
                          }
                        });
                      },
                      color: kPrimaryGreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("BOOK APPOINTMENT",
                          style: TextStyle(
                              color: kPrimaryYellow,
                              fontFamily: 'PT Serif',
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ),
            ),
          ])),
    );
  }
}

Widget textProfile({label, text}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Text(label,
            style: TextStyle(
              color: kFieldTextColor,
              fontSize: 13,
              fontFamily: 'PT Serif',
              fontWeight: FontWeight.w600,
            )),
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Source Sans',
                fontWeight: FontWeight.w600,
              ),
            ))
      ],
    ),
  );
}

Widget makeInput({label, required: true, controller}) {
  return Padding(
    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
    child: TextFormField(
      cursorColor: kPrimaryGreen,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      style: TextStyle(
          fontSize: 14,
          fontFamily: 'Source Sans',
          fontWeight: FontWeight.w400,
          color: Colors.black),
      onChanged: (value) {
        debugPrint('something changed in this feld');
      },
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'Source Sans',
              fontWeight: FontWeight.w400,
              color: kFieldTextColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    ),
  );
}
