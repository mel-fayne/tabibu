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
                    makeInput(
                      label: "Patient ID *",
                      controller: patientidController,
                      required: true,
                    ),
                    makeInput(
                      label: "Disease *",
                      controller: diseaseController,
                      required: true,
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
                      label: "Avg. Weight *",
                      controller: weightController,
                      required: true,
                    ),
                    makeInput(
                      label: "Avg. Temperature *",
                      controller: temperatureController,
                      required: true,
                    ),
                    makeInput(
                        label: "Avg. Blood Pressure *",
                        controller: bloodpressureController),
                    makeInput(
                      label: "Pulse Rate *",
                      controller: pulserateController,
                      required: true,
                    ),
                    makeInput(
                      label: "Diagnosis Symptoms*",
                      controller: symptomsController,
                      required: true,
                    ),
                    makeInput(
                      label: "Diagnosis Description *",
                      controller: descriptionController,
                      required: true,
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
                        label: "Medicine *",
                        required: true,
                        controller: medicineController),
                    makeInput(
                        label: "Prescription *",
                        required: true,
                        controller: prescriptionController),
                    makeInput(
                        label: "Additional Treatment Information",
                        controller: additionaltreatmentinfoController),
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

    diagnosis.diagnosisdate = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (diagnosis.diagnosisid != null) {
      // Case 1: Update operation
      result = await helper.updateDiagnosis(diagnosis);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertDiagnosis(diagnosis);
    }

    if (result != 0) {
      // Success
      showflushbar(message: 'Medical Record saved');
    } else {
      // Failure
      showflushbar(
          message:
              'Error encountered when saving record!\nTry again after a few moments');
    }
  }

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

Widget makeInput({
  controller,
  label,
  insert,
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
}
