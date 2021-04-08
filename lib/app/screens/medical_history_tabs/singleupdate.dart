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
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'More Updates Details',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'PT Serif',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ListTile(
                      title: Text('Update Date: 15/03/2021\nUpdate ID: U002/2',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      subtitle: Text(
                          "How have you been feeling: 🤕I feel pain\nWhich part of your body aches? Chest\nRate the amount of pain you feel: 2 out of 5\nAny New Symptoms: I've developed a rush on my neck\nHave you taken the medicine as prescribed? No I skipped a day last week\nAny Treatment Side Effects: None\nAdditional Info: My breathing rate has improved and I feel less anxious.",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                              color: kFieldTextColor)),
                      trailing: Icon(
                        Icons.update,
                        color: kPrimaryGreen,
                        size: 46,
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                        fontSize: 16,
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ],
                        )
                      ])),
            ])));
  }
}
