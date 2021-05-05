import 'package:Tabibu/app/screens/doctors/doctordashboard.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorDetails extends StatefulWidget {
  static const routeName = "/doctordetails";

  //accepting parameters from previous screen
  final String userid;
  final String fullname;
  DoctorDetails({@required this.userid, @required this.fullname});
  @override
  State<StatefulWidget> createState() {
    return DoctorDetailsState(this.userid, this.fullname);
  }
}

class DoctorDetailsState extends State<DoctorDetails> {
  String userid;
  String fullname;
  DoctorDetailsState(this.userid, this.fullname);

  String drid;

  TextEditingController hospitalctrl,
      specialtyctrl,
      practiceyearsctrl,
      aboutctrl,
      liscencectrl,
      daysctrl,
      userctrl,
      timectrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hospitalctrl = new TextEditingController();
    specialtyctrl = new TextEditingController();
    practiceyearsctrl = new TextEditingController();
    aboutctrl = new TextEditingController();
    liscencectrl = new TextEditingController();
    daysctrl = new TextEditingController();
    userctrl = new TextEditingController();
    timectrl = new TextEditingController();
  }

  Future registerDoctor() async {
    var url = "http://192.168.0.15/tabibu/api/doctors/postdoctors.php";
    var data = {
      "hospital": hospitalctrl.text,
      "specialty": specialtyctrl.text,
      "practiceyrs": practiceyearsctrl.text,
      "about": aboutctrl.text,
      "liscence": liscencectrl.text,
      "days": daysctrl.text,
      "time": timectrl.text,
      "userid": userid
    };

    var res = await http.post(url, body: data);
    var doc = jsonDecode(res.body);

    if (doc == "doctor user exists") {
      Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "The doctor account exists! Check your user id field",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
      print("doctor user exists");
    } else {
      if (doc == "error") {
        Flushbar(
          icon: Icon(Icons.error, size: 28, color: Colors.yellow),
          message: "An error occured! Try again later",
          margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
          borderRadius: 10,
          backgroundColor: kPrimaryGreen,
          duration: Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context);
        print("error");
      } else {
        print("Yoooo! It worked!");
        print(doc);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDashboard(
                fullname: fullname,
                userid: userid,
                drid: drid,
              ),
            ));
      }
    }
    setState(() {});
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
                          "Just one more step ...",
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
                        label: "Base Hospital Location *",
                        controller: hospitalctrl),
                    makeInput(label: "Specialty *", controller: specialtyctrl),
                    makeInput(
                        label: "Doctor Liscence ID *",
                        controller: liscencectrl),
                    makeInput(
                        label: "Years of Medical Practise *",
                        controller: practiceyearsctrl,
                        type: TextInputType.number),
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
                child: processing
                    ? CircularProgressIndicator()
                    : MaterialButton(
                        minWidth: double.infinity,
                        height: 40,
                        onPressed: () {
                          debugPrint("Save button clicked");
                          processing = true;
                          registerDoctor();
                        },
                        color: kPrimaryGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text("FINISH SETUP",
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
