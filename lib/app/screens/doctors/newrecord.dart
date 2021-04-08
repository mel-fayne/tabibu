import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

class NewRecord extends StatelessWidget {
  static const routeName = "/newrecord";
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
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            'Diagnosis ID: R02/3\nDate: 10/03/2021',
                            style: TextStyle(
                              color: kFieldTextColor,
                              fontSize: 14,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Doctor ID: D012/2\nPatient ID: P003/2',
                            style: TextStyle(
                              color: kFieldTextColor,
                              fontSize: 14,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    makeInput(
                        label: "Disease *",
                        required: true,
                        fieldName: "disease"),
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
                      fieldName: "weight",
                      required: true,
                    ),
                    makeInput(
                      label: "Avg. Temperature *",
                      fieldName: "temperature",
                      required: true,
                    ),
                    makeInput(
                        label: "Avg. Blood Pressure *",
                        fieldName: "blood_pressure"),
                    makeInput(
                      label: "Pulse Rate *",
                      fieldName: "pulse_rate",
                      required: true,
                    ),
                    makeInput(
                      label: "Diagnosis Symptoms*",
                      fieldName: "symptoms",
                      required: true,
                    ),
                    makeInput(
                      label: "Diagnosis Description *",
                      fieldName: "symptoms",
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
                        fieldName: "medicine"),
                    makeInput(
                        label: "Prescription *",
                        required: true,
                        fieldName: "prescription"),
                    makeInput(
                        label: "Additional Treatment Information",
                        fieldName: "additional_info"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  onPressed: () {},
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

Widget makeInput({
  label,
  required: false,
  fieldName,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Source Sans',
            fontWeight: FontWeight.w400,
            color: kFieldTextColor),
      ),
      SizedBox(
        height: 5,
      ),
      TextFormField(onSaved: (value) {}),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
