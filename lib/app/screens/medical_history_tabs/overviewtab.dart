import 'package:Tabibu/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OverviewTab extends StatefulWidget {
  static const routeName = "/overviewtab";

  @override
  _OverviewTabState createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 20),
                    child: Text(
                      'Assesments (2)',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PT Serif',
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.healing,
                          color: Colors.purple,
                          size: 55,
                        ),
                        title: Text('Diagnosis: Depression',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        subtitle: Text('Current Status: On Treatment',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: kFieldTextColor)),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.healing,
                          color: Colors.purple,
                          size: 55,
                        ),
                        title: Text('Diagnosis: Anxiety',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        subtitle: Text('Current Status: Treated',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Source Sans',
                                fontWeight: FontWeight.w600,
                                color: kFieldTextColor)),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 20),
                    child: Text(
                      'Diagnosis (2)',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PT Serif',
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    )),
                Container(
                    width: double.infinity,
                    //  padding: EdgeInsets.only(left: 10),
                    child: Column(children: [
                      Card(
                        color: kPrimaryYellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              "10/03/2021\n We noted an improvement in John's drinking habits.\n He has a more postive outlook and the treatment\n is taking effect as expected.",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Source Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                      Card(
                        color: kPrimaryAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              "23/02/2021\n We noted an improvement in John's drinking habits.\n He has a more postive outlook and the treatment\n is taking effect as expected.",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Source Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                      Card(
                        color: kPrimaryAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              "16/01/2021\n We noted an improvement in John's drinking habits.\n He has a more postive outlook and the treatment\n is taking effect as expected.",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Source Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                    ])),
              ],
            )));
  }
}
