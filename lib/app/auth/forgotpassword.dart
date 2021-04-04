import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  static const routeName = "/forgotpassword";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Forgot Password",
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
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Email Address'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  )),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: MaterialButton(
                  onPressed: () {},
                  height: 40,
                  minWidth: 327,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("SEND ME A RECOVERY EMAIL",
                      style: TextStyle(
                          color: kPrimaryYellow,
                          fontFamily: 'PT Serif',
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  color: kPrimaryGreen,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
