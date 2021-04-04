import 'package:Tabibu/app/auth/forgotpassword.dart';
import 'package:Tabibu/app/auth/signup.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  static const routeName = "/signin";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Address *',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Invalid email!';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                          TextFormField(
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
                          ),
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
                          onPressed: () {},
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
                            ))),
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
}
