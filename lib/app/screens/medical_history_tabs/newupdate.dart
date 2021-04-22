import 'package:Tabibu/app/theme/colors.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewUpdate extends StatefulWidget {
  static const routeName = "/newupdate";

  @override
  _NewUpdateState createState() => _NewUpdateState();
}

class _NewUpdateState extends State<NewUpdate> {
  String _myRating;

  TextEditingController datectrl,
      doctoridctrl,
      patientidctrl,
      feelctrl,
      partachectrl,
      newsymptomctrl,
      medicineintakectrl,
      sideeffectctrl,
      additionalinfoctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doctoridctrl = new TextEditingController();
    patientidctrl = new TextEditingController();
    feelctrl = new TextEditingController();
    partachectrl = new TextEditingController();
    newsymptomctrl = new TextEditingController();
    medicineintakectrl = new TextEditingController();
    sideeffectctrl = new TextEditingController();
    additionalinfoctrl = new TextEditingController();
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
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Update Questionnaire',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                            ))),
                    makeInput(
                        label: "How have you been feeling *",
                        controller: feelctrl),
                    makeInput(
                        label: "Which part of your body aches? *",
                        controller: partachectrl),
                    DropDownFormField(
                      titleText: 'Rate the amount of pain you feel *',
                      hintText: 'Choose between 1 and 5',
                      value: _myRating,
                      onSaved: (value) {
                        setState(() {
                          _myRating = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _myRating = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "One",
                          "value": "one",
                        },
                        {
                          "display": "Two",
                          "value": "two",
                        },
                        {
                          "display": "Three",
                          "value": "three",
                        },
                        {
                          "display": "Four",
                          "value": "four",
                        },
                        {
                          "display": "Five",
                          "value": "five",
                        }
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                    makeInput(
                        label: "Any New Symptoms? *",
                        controller: newsymptomctrl),
                    makeInput(
                      label: "Have you taken the medicine as prescribed? *",
                      controller: medicineintakectrl,
                    ),
                    makeInput(
                      label: "Any Treatment Side Effects? *",
                      controller: sideeffectctrl,
                    ),
                    makeInput(
                      label: "Additional Info ",
                      controller: additionalinfoctrl,
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
