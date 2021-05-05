import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:Tabibu/app/theme/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NewUpdate extends StatefulWidget {
  static const routeName = "/newrecord";
  @override
  State<StatefulWidget> createState() {
    return NewUpdateState();
  }
}

class NewUpdateState extends State<NewUpdate> {
  String painrate;
  String medintake;

  TextEditingController datectrl,
      docidctrl,
      ptidctrl,
      feelctrl,
      partctrl,
      newsympctrl,
      sidectrl,
      additionalctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    docidctrl = TextEditingController();
    datectrl = TextEditingController();
    ptidctrl = TextEditingController();
    sidectrl = TextEditingController();
    feelctrl = TextEditingController();
    partctrl = TextEditingController();
    newsympctrl = TextEditingController();
    additionalctrl = TextEditingController();
  }

  Future addUpdate() async {
    setState(() {});
    var url = "http://192.168.0.15/tabibu/api/updates/postupdates.php";
    var data = {
      "patientid": ptidctrl.text,
      "doctorid": docidctrl.text,
      "date": datectrl.text,
      "sideeffect": sidectrl.text,
      "feel": feelctrl.text,
      "partache": partctrl.text,
      "newsymptom": newsympctrl.text,
      "additional": additionalctrl.text,
      "medintake": medintake,
      "painrate": painrate
    };

    var res = await http.post(url, body: data);
    var update = json.decode(res.body);

    if (update == "error") {
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
      print(update);
      Flushbar(
        icon: Icon(Icons.error, size: 28, color: Colors.yellow),
        message: "Update sent successfully",
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        borderRadius: 10,
        backgroundColor: kPrimaryGreen,
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
      Navigator.of(context).pop();
    }

    setState(() {});
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
          color: Colors.white,
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
                      'General Update Details:',
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
                    ),
                    makeInput(
                      label: "Doctor ID *",
                      controller: docidctrl,
                      hint:
                          "Enter the Doctor ID of the the doctor the update is being sent to",
                    ),
                    makeInput(
                      label: "Patient ID *",
                      controller: ptidctrl,
                      hint: "Enter your Tabibu Account Patient ID",
                    ),
                    Text(
                      'Medical Update Details:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    makeInput(
                      label: "How have you been feeling? *",
                      controller: feelctrl,
                    ),
                    makeInput(
                      label:
                          "Any part of your body aching? If yes, which part?*",
                      controller: partctrl,
                    ),
                    DropDownFormField(
                      titleText: 'Rate the amount of pain you feel *',
                      hintText: 'Choose between zero and five',
                      value: painrate,
                      onSaved: (value) {
                        setState(() {
                          painrate = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          painrate = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "Zero",
                          "value": "Zero",
                        },
                        {
                          "display": "One",
                          "value": "One",
                        },
                        {
                          "display": "Two",
                          "value": "Two",
                        },
                        {
                          "display": "Three",
                          "value": "Three",
                        },
                        {
                          "display": "Four",
                          "value": "Four",
                        },
                        {
                          "display": "Five",
                          "value": "Five",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                    makeInput(
                      label:
                          "Any new symptoms? If yes, state these new symptoms *",
                      controller: newsympctrl,
                    ),
                    DropDownFormField(
                      titleText:
                          'Have you taken all your medicine as prescribed? *',
                      hintText: 'Be very honest :)',
                      value: medintake,
                      onSaved: (value) {
                        setState(() {
                          medintake = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          medintake = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "Yes",
                          "value": "Yes",
                        },
                        {
                          "display": "No",
                          "value": "No",
                        }
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                    makeInput(
                      label:
                          "Any treatment Side Effects? If yes, state these side effects*",
                      controller: sidectrl,
                    ),
                    makeInput(
                      label: "Additional Information *",
                      controller: additionalctrl,
                    ),
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
                            debugPrint("Save record button clicked");
                            processing = true;
                            addUpdate();
                          });
                        },
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
