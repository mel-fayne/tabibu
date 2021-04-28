import 'package:Tabibu/app/screens/patientdashboard.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientDetails extends StatefulWidget {
  static const routeName = "/patientdetails";

  //accepting parameters from previous screen
  final String userid;
  final String fullname;
  PatientDetails({@required this.userid, @required this.fullname});
  @override
  State<StatefulWidget> createState() {
    return PatientDetailsState(this.userid, this.fullname);
  }
}

class PatientDetailsState extends State<PatientDetails> {
  String userid;
  String fullname;

  PatientDetailsState(this.userid, this.fullname);

  String _condtype;
  String _myPayment;
  String _myBloodType;
  String _myStatus;

  TextEditingController useridctrl, dobctrl, conditionnamectrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    useridctrl = new TextEditingController();
    dobctrl = new TextEditingController();
    conditionnamectrl = new TextEditingController();
  }

  Future registerPatient() async {
    setState(() {});
    var url = "http://192.168.0.15/tabibu/api/patients/postpatients.php";
    var data = {
      "userid": useridctrl.text,
      "dob": dobctrl.text,
      "condition_type": _condtype,
      "condition_name": conditionnamectrl.text,
      "blood_type": _myBloodType,
      "payment_mode": _myPayment,
      "status": _myStatus
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "account already exists") {
      Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "The user account already exists!",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
      print("account already exists");
    } else {
      if (jsonDecode(res.body) == "true") {
        print("Yoooo! It worked!");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PatientDashboard(fullname: fullname, userid: userid),
            ));
      } else {
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
                      padding: EdgeInsets.only(top: 10),
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
                  children: <Widget>[
                    makeInput(
                      label: "User ID *",
                      controller: useridctrl,
                      hint:
                          "Your user ID is $userid. Fill this id in this field",
                    ),
                    makeInput(label: "Date of Birth *", controller: dobctrl),
                    DropDownFormField(
                      titleText: 'Type of Condition',
                      hintText: 'Choose your type of condition',
                      value: _condtype,
                      onSaved: (value) {
                        setState(() {
                          _condtype = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _condtype = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "Pre-existing",
                          "value": "pre-existing",
                        },
                        {
                          "display": "Subsequent",
                          "value": "subsequent",
                        }
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                    makeInput(
                        label: "Name of Condition *",
                        controller: conditionnamectrl),
                    DropDownFormField(
                      titleText: 'Blood Type',
                      hintText: 'Choose your blood type',
                      value: _myBloodType,
                      onSaved: (value) {
                        setState(() {
                          _myBloodType = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _myBloodType = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "Type A",
                          "value": "A",
                        },
                        {
                          "display": "Type B",
                          "value": "B",
                        },
                        {
                          "display": "Type AB",
                          "value": "AB",
                        },
                        {
                          "display": "Type O",
                          "value": "O",
                        }
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                    DropDownFormField(
                      titleText: 'Mode of Medical Payments',
                      hintText: 'Choose mode of payment',
                      value: _myPayment,
                      onSaved: (value) {
                        setState(() {
                          _myPayment = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _myPayment = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "NHIF",
                          "value": "nhif",
                        },
                        {
                          "display": "Cash",
                          "value": "cash",
                        },
                        {
                          "display": "Other",
                          "value": "other",
                        }
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                    DropDownFormField(
                      titleText: 'Medical Status',
                      hintText: 'Choose your current medical status:',
                      value: _myStatus,
                      onSaved: (value) {
                        setState(() {
                          _myStatus = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _myStatus = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "On Treatment",
                          "value": "treatment",
                        },
                        {
                          "display": "Diagnosed",
                          "value": "diagnosed",
                        },
                        {
                          "display": "Undiagnosed",
                          "value": "diagnosed",
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
                    Navigator.of(context).pushNamed(PatientDashboard.routeName);
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
    {label, obscureText = false, hint, required: true, controller, type}) {
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
