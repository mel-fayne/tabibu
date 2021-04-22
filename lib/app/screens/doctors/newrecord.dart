import 'package:Tabibu/app/theme/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class NewRecord extends StatefulWidget {
  static const routeName = "/newrecord";
  @override
  State<StatefulWidget> createState() {
    return NewRecordState();
  }
}

class NewRecordState extends State<NewRecord> {
  String _myRole;

  TextEditingController doctoridctrl,
      datectrl,
      patientidctrl,
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
    doctoridctrl = TextEditingController();
    datectrl = TextEditingController();
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
                      'Diagnosis Details:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    makeInput(
                      label: "Date *",
                      controller: datectrl,
                      type: TextInputType.datetime,
                    ),
                    makeInput(
                      label: "Doctor ID *",
                      controller: doctoridctrl,
                    ),
                    makeInput(
                      label: "Patient ID *",
                      controller: patientidctrl,
                    ),
                    makeInput(
                      label: "Disease *",
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
                      label: "Weight (in kilograms)*",
                      controller: weightctrl,
                    ),
                    makeInput(
                      label: "Temperature (in degrees celcius) *",
                      controller: tempctrl,
                    ),
                    makeInput(
                      label: "Blood Pressure (in mmHg)*",
                      controller: pressurectrl,
                    ),
                    makeInput(
                      label: "Pulse (in beats/minute)*",
                      controller: pulsectrl,
                    ),
                    makeInput(
                      label: "Symptoms *",
                      controller: symptomsctrl,
                    ),
                    makeInput(
                      label: "Description *",
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
                      label: "Medicine *",
                      controller: medicinectrl,
                    ),
                    makeInput(
                      label: "Prescription *",
                      controller: prescriptionctrl,
                    ),
                    makeInput(
                        label: "Additional Treatment Info *",
                        controller: treatmentinfoctrl),
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

Widget makeInput({label, required: true, controller, type}) {
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
