import 'package:Tabibu/app/auth/signin.dart';
import 'package:Tabibu/app/screens/doctors/doctordashboard.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

class DoctorDetails extends StatelessWidget {
  static const routeName = "/doctordetails";
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
          height: MediaQuery.of(context).size.height - 70,
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
                        label: "Base Hospital Location *",
                        required: true,
                        fieldName: "hospital"),
                    makeInput(label: "Specialty *", fieldName: "specialty"),
                    makeInput(
                        label: "Doctor Liscence ID *",
                        fieldName: "liscence_id"),
                    makeInput(
                        label: "Years of Medical Practise *",
                        fieldName: "practice_years"),
                    makeInput(
                        label: "Patient Load Limit *", fieldName: "load_limit"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  onPressed: () {
                    Navigator.of(context).pushNamed(DoctorDashboard.routeName);
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
                  padding: EdgeInsets.only(top: 10),
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
    {label,
    obscureText = false,
    toggle = false,
    required: false,
    fieldName,
    validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 16,
            fontFamily: 'Source Sans',
            fontWeight: FontWeight.w400,
            color: kFieldTextColor),
      ),
      SizedBox(
        height: 5,
      ),
      TextFormField(
        onSaved: (value) {
          /*    if (fieldName != null) {
                newUser[fieldName] = value;
              }
            },
            validator: (value) {
              var res = null;
// Check if any custom validators included and if required
              if (validator != null) {
                var cvalidator = validator(value);
                if (cvalidator != null) return cvalidator;
              }

// Check if required or not
              if (required && (value == null || value == '')) {
                res = "This field may not be blank.";
              }

// check if any errors available (From the server)
              if (erros.containsKey(fieldName)) {
                res = erros[fieldName];
              }
              return res; */
        },
        obscureText: obscureText,
        /*  decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                suffix: toggle == true
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            obscureText = true;
                          });
                        },
                        child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: kFieldTextColor,
                        ))
                    : null) */
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
