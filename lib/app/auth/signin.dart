//import 'package:Tabibu/app/auth/forgotpassword.dart';
import 'package:Tabibu/app/auth/signup.dart';
import 'package:Tabibu/app/screens/doctors/doctordashboard.dart';
import 'package:Tabibu/app/screens/patientdashboard.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignIn extends StatefulWidget {
  static const routeName = "/signin";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isHidden = true;
  String userid;
  String fullname;
  String role;
  String drid;
  String ptid;

  TextEditingController passctrl, emailctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  Future userSignIn() async {
    var url = "http://192.168.0.15/tabibu/api/auth/signin.php";
    var res = await http
        .post(url, body: {"email": emailctrl.text, "pass": passctrl.text});
    var data = json.decode(res.body);
    if (data == "error") {
      Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "Please confirm your credentials!",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
      print("wrong password");
    } else {
      print("Yoooo! It worked!");
      Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "Succesful sign in! Welcome to Tabibu",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
      userid = data[0];
      fullname = data[1];
      role = data[2];
      print(data);
      if (role == 'doctor') {
        var docurl = "http://192.168.0.15/tabibu/api/doctors/getdoctors.php";
        var docres = await http.post(docurl, body: {"userid": userid});
        var docdata = json.decode(docres.body);
        if (docdata == "error") {
          print("sth went wrong!");
        } else {
          print("Yoooo! It worked!");
          drid = docdata[0];
          print(docdata);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorDashboard(
                    fullname: fullname, userid: userid, drid: drid),
              ));
        }
      } else {
        var pturl = "http://192.168.0.15/tabibu/api/patients/getpatients.php";
        var ptres = await http.post(pturl, body: {"userid": userid});
        var ptdata = json.decode(ptres.body);
        if (ptdata == "error") {
          print("sth went wrong!");
        } else {
          print("Yoooo! It worked!");
          ptid = ptdata[0];
          print(ptdata);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PatientDashboard(
                    fullname: fullname, userid: userid, ptid: ptid),
              ));
        }
      }
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Sign in",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Source Sans',
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700)))),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: <Widget>[
                          makeInput(
                            label: "Email Address *",
                            controller: emailctrl,
                            type: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            cursorColor: kPrimaryGreen,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            decoration: InputDecoration(
                                labelText: 'Password *',
                                labelStyle: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Source Sans',
                                    fontWeight: FontWeight.w400,
                                    color: kFieldTextColor),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                suffix: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: kFieldTextColor,
                                  ),
                                )),
                            obscureText: _isHidden,
                            controller: passctrl,
                            validator: (value) {
                              if (value.isEmpty || value.length < 1) {
                                return 'Password is too short!';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: EdgeInsets.only(top: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: processing
                            ? CircularProgressIndicator()
                            : MaterialButton(
                                minWidth: double.infinity,
                                height: 50,
                                onPressed: () {
                                  processing = true;
                                  userSignIn();
                                },
                                color: kPrimaryGreen,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text("SIGN IN",
                                    style: TextStyle(
                                        color: kPrimaryYellow,
                                        fontFamily: 'PT Serif',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                              ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(SignUp.routeName);
                            },
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'New User? ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Source Sans',
                                    fontWeight: FontWeight.w400,
                                    color: kTextColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Create a Tabibu Account',
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
          ],
        ),
      ),
    );
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
