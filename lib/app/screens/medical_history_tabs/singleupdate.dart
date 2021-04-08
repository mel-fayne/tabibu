import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';

class SingleUpdate extends StatefulWidget {
  static const routeName = "/singleupdate";

  @override
  _SingleUpdateState createState() => _SingleUpdateState();
}

class _SingleUpdateState extends State<SingleUpdate> {
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
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Column(children: [
              Text(
                'More Updates Deatails',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'PT Serif',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(
                      """ Update Date: 15/03/2021\nUpdate ID: U002/2\n
                              How have you been feeling: 🤕I feel pain\n
                              Which part of your body aches? Chest\n
                              Rate the amount of pain you feel: 2 out of 5\n
                              Any New Symptoms: I've developed a rush on my neck\n
                              Have you taken the medicine as prescribed? No I skipped a day last week\n
                              Any Treatment Side Effects: None\n
                              Additional Info: My breathing rate has improved and I feel less anxious.""",
                      style: TextStyle(
                        color: kFieldTextColor,
                        fontSize: 14,
                        fontFamily: 'Source Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Icon(
                          Icons.details,
                          color: kPrimaryYellow,
                          size: 26,
                        ))
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(children: [
                    Text(
                      'Actions:',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Source Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: MaterialButton(
                            minWidth: 100,
                            height: 40,
                            onPressed: () {},
                            color: kPrimaryGreen,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("Mark as Seen",
                                style: TextStyle(
                                    color: kPrimaryYellow,
                                    fontFamily: 'PT Serif',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                        Container(
                          child: MaterialButton(
                            minWidth: 100,
                            height: 40,
                            onPressed: () {},
                            color: kPrimaryGreen,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("Make an Appointment",
                                style: TextStyle(
                                    color: kPrimaryYellow,
                                    fontFamily: 'PT Serif',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    )
                  ])),
            ])));
  }
}
