import 'package:Tabibu/app/auth/doctordetails.dart';
import 'package:Tabibu/app/auth/patientdetails.dart';
import 'package:Tabibu/app/auth/signin.dart';
import 'package:Tabibu/app/screens/doctors/doctordashboard.dart';
import 'package:Tabibu/app/screens/patientdashboard.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  static const routeName = "/signup";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _myRole;
  bool signin = true;

  TextEditingController namectrl, emailctrl, mobilectrl, countyctrl, passctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    mobilectrl = new TextEditingController();
    countyctrl = new TextEditingController();
    passctrl = new TextEditingController();
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
          // height: MediaQuery.of(context).size.height - 70,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Create Tabibu Account",
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
                  children: <Widget>[
                    makeInput(
                      label: "Full Name *",
                      controller: namectrl,
                    ),
                    makeInput(
                      label: "Email Address *",
                      controller: emailctrl,
                      type: TextInputType.emailAddress,
                    ),
                    makeInput(
                      label: "Mobile Number *",
                      controller: mobilectrl,
                      type: TextInputType.number,
                    ),
                    makeInput(
                      label: "Residence County *",
                      controller: countyctrl,
                    ),
                    makeInput(
                      label: "Password *",
                      controller: passctrl,
                      obscureText: true,
                    ),
                    makeInput(
                        required: true,
                        label: "Confirm Password",
                        obscureText: true),
                    DropDownFormField(
                      titleText: 'Role',
                      hintText: 'Please choose your category',
                      value: _myRole,
                      onSaved: (value) {
                        setState(() {
                          _myRole = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _myRole = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "Patient",
                          "value": "patient",
                        },
                        {
                          "display": "Doctor",
                          "value": "doctor",
                        }
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  onPressed: () {
                    registerUser();
                  },
                  color: kPrimaryGreen,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("REGISTER",
                      style: TextStyle(
                          color: kPrimaryYellow,
                          fontFamily: 'PT Serif',
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              /* Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose your Role:',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w400,
                        color: kFieldTextColor),
                  )),
              Container(
                  padding: EdgeInsets.only(left: 50, top: 10),
                  child: Row(
                    children: [
                      MaterialButton(
                        minWidth: 120,
                        height: 40,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(DoctorDetails.routeName);
                        },
                        color: kPrimaryGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text("Doctor",
                            style: TextStyle(
                                color: kPrimaryYellow,
                                fontFamily: 'PT Serif',
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: MaterialButton(
                            minWidth: 120,
                            height: 40,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(PatientDetails.routeName);
                            },
                            color: kPrimaryGreen,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("Patient",
                                style: TextStyle(
                                    color: kPrimaryYellow,
                                    fontFamily: 'PT Serif',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          )),
                    ],
                  )), */
              Container(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(SignIn.routeName);
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Already have a Tabibu Account? ',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w400,
                              color: kTextColor),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Source Sans',
                                    fontWeight: FontWeight.w700,
                                    color: kPrimaryYellow)),
                          ],
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    setState(() {
      processing = true;
    });
    var url = "http://192.168.0.15/tabibu/api/auth/signup.php";
    var data = {
      "name": namectrl.text,
      "email": emailctrl.text,
      "mobilenumber": int.parse(mobilectrl.text),
      "county": countyctrl.text,
      "pass": passctrl.text,
      "role": _myRole
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "account already exists") {
      showFlushbar(
        message: "The user account already exists!\nConfirm your email",
      );
    } else {
      if (jsonDecode(res.body) == "true") {
        showFlushbar(
          message: "Account Succesfuly Created!\nWelcome to Tabibu",
        );
        if (_myRole == "patient") {
          Navigator.of(context).pushNamed(PatientDashboard.routeName);
        } else {
          Navigator.of(context).pushNamed(DoctorDashboard.routeName);
        }
      } else {
        showFlushbar(
          message: "An error occured!",
        );
      }
    }
    setState(() {
      processing = false;
    });
  }

  void userSignIn() async {
    setState(() {
      processing = true;
    });
    var url = "";
    var data = {
      "email": emailctrl.text,
      "pass": passctrl.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "dont have an account") {
      showFlushbar(
          message:
              "The account doesn't exist!\nSign up to create a Tabibu account");
    } else {
      if (jsonDecode(res.body) == "false") {
        showFlushbar(message: "Incorrect Password!");
      } else {
        print(jsonDecode(res.body));
      }
    }

    setState(() {
      processing = false;
    });
  }
}

Widget makeInput(
    {label, obscureText = false, required: true, controller, type}) {
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
