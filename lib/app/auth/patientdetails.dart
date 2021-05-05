import 'package:intl/intl.dart';
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
  String ptid;

  PatientDetailsState(this.userid, this.fullname);

  String _myPayment;
  String _myBloodType;

  DateTime selectedDate = DateTime.now();
  String formattedDate;

  TextEditingController preexistingctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preexistingctrl = TextEditingController();
  }

  Future registerPatient() async {
    setState(() {});
    var url = "http://192.168.0.15/tabibu/api/patients/postpatients.php";
    var data = {
      "userid": userid,
      "dob": formattedDate,
      "preexisting_cond": preexistingctrl.text,
      "blood_type": _myBloodType,
      "payment_mode": _myPayment,
    };

    var res = await http.post(url, body: data);
    var ptn = jsonDecode(res.body);

    if (ptn == "patient user exists") {
      Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "The user account already exists!",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
      print("patient user exists");
    } else {
      if (ptn == "error") {
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
        ptid = ptn[0];
        print(ptn);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDashboard(
                  fullname: fullname, userid: userid, ptid: ptid),
            ));
      }
    }
    setState(() {});
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 36000)),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
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
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          RaisedButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              'Select your date of birth',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Source Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            color: kPrimaryAccent,
                          ),
                          Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
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
                    makeInput(
                      label:
                          'Do you have a pre-existing condition?\nIf yes, state which condition *',
                      controller: preexistingctrl,
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
                          processing = true;
                          registerPatient();
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

Widget makeInput({label, required: true, controller, hint, type}) {
  return Padding(
    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
    child: TextField(
      cursorColor: kPrimaryGreen,
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
