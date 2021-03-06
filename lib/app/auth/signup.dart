import 'package:Tabibu/app/auth/doctordetails.dart';
import 'package:Tabibu/app/auth/patientdetails.dart';
import 'package:Tabibu/app/auth/signin.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  static const routeName = "/signup";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _myRole;
  String userid;
  String fullname;

  TextEditingController namectrl,
      emailctrl,
      countyctrl,
      passctrl,
      confirmpassctrl;

  final _formKey = GlobalKey<FormState>();

  bool processing = false;
  bool _isHidden = true;

  Future registerUser() async {
    setState(() {});
    var url = "http://192.168.0.15/tabibu/api/auth/signup.php";
    var data = {
      "name": namectrl.text,
      "email": emailctrl.text,
      "county": countyctrl.text,
      "pass": passctrl.text,
      "role": _myRole
    };

    var res = await http.post(url, body: data);
    var user = json.decode(res.body);

    if (user == "account already exists") {
      print("account already exists");
      return Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "The user account already exists!",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    } else {
      if (user == "error") {
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
        userid = user[0];
        fullname = user[1];
        print(user);
        if (_myRole == "patient") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PatientDetails(userid: userid, fullname: fullname),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DoctorDetails(userid: userid, fullname: fullname),
              ));
        }
      }
    }
    setState(() {});
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    //  mobilectrl = new TextEditingController();
    countyctrl = new TextEditingController();
    passctrl = new TextEditingController();
    confirmpassctrl = new TextEditingController();
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
                      label: "Full Name",
                      controller: namectrl,
                    ),
                    makeInput(
                      label: "Email Address",
                      controller: emailctrl,
                      type: TextInputType.emailAddress,
                    ),
                    makeInput(
                      label: "Residence County",
                      controller: countyctrl,
                    ),
                    TextFormField(
                      cursorColor: kPrimaryGreen,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Password',
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          cursorColor: kPrimaryGreen,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          decoration: InputDecoration(
                              labelText: 'Confirm your Password',
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
                          controller: confirmpassctrl,
                          validator: (val) {
                            if (val.isEmpty)
                              return 'Please confirm your Password';
                            if (val != confirmpassctrl.text)
                              return 'Passwords do not match!';
                            return null;
                          },
                          onSaved: (value) {},
                        )),
                    DropDownFormField(
                      titleText: 'Role',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Role';
                        }
                        return null;
                      },
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
                child: processing
                    ? CircularProgressIndicator()
                    : MaterialButton(
                        minWidth: double.infinity,
                        height: 40,
                        onPressed: () {
                          //  if (_formKey.currentState.validate()) {
                          //    processing = true;
                          registerUser();
                          //  }
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
}

Widget makeInput(
    {label, obscureText = false, required: true, controller, type}) {
  return Padding(
    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
    child: TextFormField(
      cursorColor: kPrimaryGreen,
      obscureText: obscureText,
      controller: controller,
      keyboardType: type,
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
