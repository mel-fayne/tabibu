import 'package:Tabibu/app/theme/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class NewRecord extends StatefulWidget {
  static const routeName = "/newrecord";
  final String drid;
  NewRecord({@required this.drid});
  @override
  State<StatefulWidget> createState() {
    return NewRecordState(this.drid);
  }
}

class NewRecordState extends State<NewRecord> {
  String drid;
  NewRecordState(this.drid);

  TextEditingController patientidctrl,
      diseasectrl,
      descriptionctrl,
      weightctrl,
      tempctrl,
      pulsectrl,
      pressurectrl,
      symptomsctrl,
      medicinectrl,
      prescriptionctrl,
      treatmentinfoctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    patientidctrl = TextEditingController();
    diseasectrl = TextEditingController();
    descriptionctrl = TextEditingController();
    weightctrl = TextEditingController();
    tempctrl = TextEditingController();
    pulsectrl = TextEditingController();
    pressurectrl = TextEditingController();
    symptomsctrl = TextEditingController();
    medicinectrl = TextEditingController();
    prescriptionctrl = TextEditingController();
    treatmentinfoctrl = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  String formattedDate;

  Future addDiagnosis() async {
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    setState(() {});
    var url = "http://192.168.0.15/tabibu/api/diagnosis/postdiagnosis.php";
    var data = {
      "disease": diseasectrl.text,
      "description": descriptionctrl.text,
      "date": formattedDate,
      "weight": weightctrl.text,
      "temp": tempctrl.text,
      "pulse": pulsectrl.text,
      "pressure": pressurectrl.text,
      "symptoms": symptomsctrl.text,
      "medicine": medicinectrl.text,
      "prescription": prescriptionctrl.text,
      "treatmentinfo": treatmentinfoctrl.text,
      "status": "On Treatment",
      "dr_id": drid,
      "pt_id": patientidctrl.text
    };

    var res = await http.post(url, body: data);
    var diagnosis = json.decode(res.body);

    if (diagnosis == "error") {
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
      print(diagnosis);
      Navigator.of(context).pop();
      return Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "Record saved successfully",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
                          "New Medical Record",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'PT Serif',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Diagnosis Details:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    makeInput(
                      label: "Patient ID",
                      controller: patientidctrl,
                      hint:
                          "Enter your patient's Tabibu Account PatientID Number",
                    ),
                    makeInput(
                      label: "Ailment/Condition",
                      controller: diseasectrl,
                    ),
                    Text(
                      'Vitals',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    makeInput(
                      label: "Weight (in kilograms)",
                      controller: weightctrl,
                    ),
                    makeInput(
                      label: "Temperature (in degrees celcius)",
                      controller: tempctrl,
                    ),
                    makeInput(
                      label: "Blood Pressure (in mmHg)",
                      controller: pressurectrl,
                    ),
                    makeInput(
                      label: "Pulse (in beats/minute)",
                      controller: pulsectrl,
                    ),
                    makeInput(
                      label: "Symptoms",
                      controller: symptomsctrl,
                    ),
                    makeInput(
                      label: "Description",
                      controller: descriptionctrl,
                    ),
                    Text(
                      'Treatment',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    makeInput(
                      label: "Medicine",
                      controller: medicinectrl,
                    ),
                    makeInput(
                      label: "Prescription",
                      controller: prescriptionctrl,
                    ),
                    makeInput(
                        label: "Additional Treatment Info",
                        controller: treatmentinfoctrl),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: processing
                    ? CircularProgressIndicator()
                    : MaterialButton(
                        minWidth: double.infinity,
                        height: 40,
                        onPressed: () {
                          setState(() {
                            //  if (_formKey.currentState.validate()) {
                            processing = true;
                            debugPrint("Save record button clicked");
                            addDiagnosis();
                            //}
                          });
                        },
                        color: kPrimaryGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text("ADD NEW RECORD",
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
    child: TextFormField(
      cursorColor: kPrimaryGreen,
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
