import 'package:Tabibu/app/models/diagnosis.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/utils/database_helper.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewRecord extends StatefulWidget {
  static const routeName = "/newrecord";

  final Diagnosis diagnosis;

  NewRecord(this.diagnosis);

  @override
  State<StatefulWidget> createState() {
    return NewRecordState(this.diagnosis);
  }
}

class NewRecordState extends State<NewRecord> {
  DatabaseHelper helper = DatabaseHelper();

  Diagnosis diagnosis;

  TextEditingController patientidController = TextEditingController();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController pulserateController = TextEditingController();
  TextEditingController bloodpressureController = TextEditingController();
  TextEditingController symptomsController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController prescriptionController = TextEditingController();
  TextEditingController additionaltreatmentinfoController =
      TextEditingController();

  NewRecordState(this.diagnosis);

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
                      'Diagnosis Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            'Diagnosis ID: R02/3\nDate: 10/03/2021',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'Doctor ID: D012/2\nDoctor Name: Dr.Jules Rue',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Source Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: patientidController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.patientid = patientidController.text as int;
                        },
                        decoration: InputDecoration(
                            labelText: 'Patient ID *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: diseaseController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.disease = diseaseController.text;
                        },
                        decoration: InputDecoration(
                            labelText: 'Disease *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
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
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: weightController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.weight = weightController.text as int;
                        },
                        decoration: InputDecoration(
                            labelText: 'Avg. Weight(in Kilograms) *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: temperatureController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.temperature =
                              temperatureController.text as int;
                        },
                        decoration: InputDecoration(
                            labelText: 'Avg. Temperature(in degrees Celcius) *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: bloodpressureController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.bloodpressure =
                              bloodpressureController.text as int;
                        },
                        decoration: InputDecoration(
                            labelText: 'Avg. Blood Pressure(in mmHg) *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: pulserateController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.pulserate = pulserateController.text as int;
                        },
                        decoration: InputDecoration(
                            labelText: 'Avg. Pulse Rate(in beats per minute) *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: symptomsController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.symptoms = symptomsController.text;
                        },
                        decoration: InputDecoration(
                            labelText: 'Diagnosis Symptoms *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: descriptionController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.description = descriptionController.text;
                        },
                        decoration: InputDecoration(
                            labelText: 'Diagnosis Description *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
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
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: medicineController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.medicine = medicineController.text;
                        },
                        decoration: InputDecoration(
                            labelText: 'Medicine *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: prescriptionController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.prescription = prescriptionController.text;
                        },
                        decoration: InputDecoration(
                            labelText: 'Prescription *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: additionaltreatmentinfoController,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        onChanged: (value) {
                          debugPrint('something changed in this feld');
                          diagnosis.additionaltreatmentinfo =
                              additionaltreatmentinfoController.text;
                        },
                        decoration: InputDecoration(
                            labelText: 'Additional Treatment Information *',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w400,
                                color: kFieldTextColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  onPressed: () {
                    setState(() {
                      debugPrint("Save record button clicked");
                      _save();
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

// Insert the diagnosis object
  void updateDisease() {
    diagnosis.disease = diseaseController.text;
  }

  // Save data to database
  void _save() async {
    Navigator.pop(context, true);
    // diagnosis.diagnosisdate = DateFormat.yMMMd().format(DateTime.now());
    int result;
    /*  if (diagnosis.diagnosisid != null) {
      // Case 1: Update operation
      result = await helper.updateDiagnosis(diagnosis);
    } else { */
    // Case 2: Insert Operation
    result = await helper.insertDiagnosis(diagnosis);
    // }
    if (result != 0) {
      // Success
      debugPrint("New record added");
      showflushbar(message: 'Medical Record saved');
    } else {
      // Failure
      showflushbar(
          message:
              'Error encountered when saving record!\nTry again after a few moments');
    }
  }

  //Show error message
  void showflushbar({message}) {
    Flushbar(
      icon: Icon(Icons.error, size: 28, color: Colors.white),
      message: message,
      margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 75, 8, 0),
      borderRadius: 10,
      backgroundColor: kPrimaryYellow,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }
}

/* Widget makeInput({
  controller,
  label,
  required: false,
}) {
  return Padding(
    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
    child: TextField(
      controller: controller,
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
} */
