import 'package:Tabibu/app/auth/forgotpassword.dart';
import 'package:Tabibu/app/auth/signup.dart';
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
  bool processing = false;

  TextEditingController passctrl, emailctrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
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
                          makeInput(
                            label: "Password *",
                            controller: passctrl,
                            obscureText: true,
                          ),
                          /* TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Password *',
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
                            // controller: _passwordController,
                            validator: (value) {
                              if (value.isEmpty || value.length < 1) {
                                return 'Password is too short!';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ), */
                        ],
                      ),
                    ),
                    /*  SizedBox(
                      height: 20,
                    ),
                    if (_is_loading)
                      CircularProgressIndicator()
                    else */
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: EdgeInsets.only(top: 45),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 50,
                          onPressed: () {
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
                    /* Container(
                        padding: EdgeInsets.only(top: 15),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(ForgotPassword.routeName);
                            },
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'FORGOT PASSWORD ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Source Sans',
                                    fontWeight: FontWeight.w700,
                                    color: kPrimaryGreen),
                              ),
                            ))), */
                    Container(
                        padding: EdgeInsets.only(top: 10),
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
