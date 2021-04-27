import 'package:Tabibu/app/screens/doctors/doctordashboard.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorDetails extends StatefulWidget {
  static const routeName = "/doctordetails";

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool processing = false;

  TextEditingController hospitalctrl,
      liscencectrl,
      practiceyearsctrl,
      specialtyctrl,
      aboutctrl,
      loadlimitctrl,
      daysctrl,
      userctrl,
      timectrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hospitalctrl = new TextEditingController();
    liscencectrl = new TextEditingController();
    practiceyearsctrl = new TextEditingController();
    loadlimitctrl = new TextEditingController();
    aboutctrl = new TextEditingController();
    specialtyctrl = new TextEditingController();
    daysctrl = new TextEditingController();
    userctrl = new TextEditingController();
    timectrl = new TextEditingController();
  }

  Future sendDetails() async {
    int _userid;
    _userid = int.parse(userctrl.text);
    setState(() {
      processing = true;
    });
    var url = "http://192.168.0.15/tabibu/api/doctors/postdoctors.php";
    var data = {
      "hospital": hospitalctrl.text,
      "liscence": liscencectrl.text,
      "practiceyrs": practiceyearsctrl.text,
      "specialty": specialtyctrl.text,
      "about": aboutctrl.text,
      "loadlimit": loadlimitctrl.text,
      "days": daysctrl.text,
      "userid": _userid,
      "time": timectrl
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "Details saved successfuly!",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    } else {
      Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "An error occured! Try again later",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    }
    setState(() {
      processing = false;
      Navigator.of(context).pushNamed(DoctorDashboard.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Finish Setting up Tabibu Account...",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    makeInput(
                      label: "User ID *",
                      controller: userctrl,
                      hint: "Please check your profile page for your user ID",
                    ),
                    makeInput(
                        label: "Base Hospital Location *",
                        controller: hospitalctrl),
                    makeInput(label: "Specialty *", controller: specialtyctrl),
                    makeInput(
                        label: "Doctor Liscence ID *",
                        controller: liscencectrl),
                    makeInput(
                        label: "Years of Medical Practise *",
                        controller: practiceyearsctrl),
                    makeInput(label: "About Me *", controller: aboutctrl),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Availability Stats',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                    makeInput(
                        label: "Patient Load Limit *",
                        hint:
                            "Enter number of patients you can manage on app e.g 20",
                        controller: loadlimitctrl),
                    makeInput(
                        label: "Days of the week when available: *",
                        hint: "E,g. Monday to Friday or Monday & Wednesday",
                        controller: daysctrl),
                    makeInput(
                        label: "Appointment Times *",
                        hint: "E.g. 8am to 12noon or 10:30am to 2pm",
                        controller: timectrl),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  onPressed: () {
                    debugPrint("Save button clicked");
                    sendDetails();
                  },
                  color: kPrimaryGreen,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("SAVE MY DETAILS",
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
      ),
    );
  }
}

Widget makeInput(
    {label, hint, obscureText = false, required: true, controller, type}) {
  return Padding(
    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
    child: TextField(
      cursorColor: kPrimaryGreen,
      obscureText: obscureText,
      controller: controller,
      keyboardType: type,
      style: TextStyle(
          fontSize: 14,
          fontFamily: 'Source Sans',
          fontWeight: FontWeight.w400,
          color: Colors.black),
      onChanged: (value) {
        debugPrint('something changed in this feld');
        //  diagnosis.patientid = patientidController.text as int;
      },
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'Source Sans',
              fontWeight: FontWeight.w400,
              color: kFieldTextColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    ),
  );
}

Widget showFlushbar({message}) {
  return Builder(builder: (BuildContext context) {
    return Flushbar(
      icon: Icon(Icons.error, size: 28, color: Colors.white),
      message: message,
      margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 75, 8, 0),
      borderRadius: 10,
      backgroundColor: kPrimaryYellow,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  });
}
