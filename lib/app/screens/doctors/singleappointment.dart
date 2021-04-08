import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class SingleAppointment extends StatelessWidget {
  static const routeName = "/singleappointment";
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
              'More Appointment Details',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'PT Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: ListTile(
                    title: Text(
                        'Appointment ID: A002/2\nDate: 15/03/2021\nTime: 0830h\nLocation: Aga Khan Hospital',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Source Sans',
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    subtitle: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                            "Purpose: New Patient Request\n Status: Pending",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: kFieldTextColor))),
                    trailing: Icon(
                      MyCustomIcons.calendar,
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
                              child: Text("Reschedule",
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
                              child: Text("Confirm",
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
          ])),
    );
  }
}
