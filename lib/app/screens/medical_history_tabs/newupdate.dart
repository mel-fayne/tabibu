import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

class NewUpdate extends StatefulWidget {
  static const routeName = "/newupdate";

  @override
  _NewUpdateState createState() => _NewUpdateState();
}

class _NewUpdateState extends State<NewUpdate> {
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
                          "New Medical Update",
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
                      'Update Details',
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Update ID: U03/3\nDate: 09/04/2021',
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(padding: EdgeInsets.only(top: 10)),
                    makeInput(
                        label: "How have you been feeling *",
                        required: true,
                        fieldName: "feeling"),
                    makeInput(
                      label: "Which part of your body aches? *",
                      fieldName: "part_aching",
                      required: true,
                    ),
                    makeInput(
                      label:
                          "Rate the amount of pain you feel between 1 and 5 *",
                      fieldName: "pain_rating",
                      required: true,
                    ),
                    makeInput(
                        label: "Any New Symptoms? *",
                        fieldName: "new_symptoms"),
                    makeInput(
                      label: "Have you taken the medicine as prescribed? *",
                      fieldName: "madicine_intake",
                      required: true,
                    ),
                    makeInput(
                      label: "Any Treatment Side Effects? *",
                      fieldName: "symptoms",
                      required: true,
                    ),
                    makeInput(
                      label: "Additional Info ",
                      fieldName: "additional_info",
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  onPressed: () {},
                  color: kPrimaryGreen,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("SEND NEW UPDATE",
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
