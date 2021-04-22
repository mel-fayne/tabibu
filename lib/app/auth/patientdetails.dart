import 'package:Tabibu/app/screens/patientdashboard.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class PatientDetails extends StatefulWidget {
  static const routeName = "/patientdetails";

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  String _myPayment;
  String _myBloodType;
  String _myStatus;
  bool processing = false;

  TextEditingController dobctrl,
      conditiontypectrl,
      conditionnamectrl,
      bloodtypectrl,
      paymentmodectrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dobctrl = new TextEditingController();
    conditiontypectrl = new TextEditingController();
    conditiontypectrl = new TextEditingController();
    bloodtypectrl = new TextEditingController();
    paymentmodectrl = new TextEditingController();
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
                          "Finish Setting up Tabibu Account ...",
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
                        label: "Date of Birth *",
                        controller: dobctrl,
                        type: TextInputType.datetime),
                    makeInput(
                        label: "Type of Condition *",
                        controller: conditiontypectrl),
                    makeInput(
                        label: "Name of Condition *",
                        controller: conditionnamectrl),
                    makeInput(label: "Blood Type", controller: bloodtypectrl),
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
