import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class TreatmentTab extends StatefulWidget {
  static const routeName = "/treatmenttab";

  @override
  _TreatmentTabState createState() => _TreatmentTabState();
}

class _TreatmentTabState extends State<TreatmentTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Treatments (1)',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'PT Serif',
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                ),
              ),
              Container(
                  width: double.infinity,
                  child: Column(children: [
                    ListTile(
                      leading: Icon(
                        MyCustomIcons.pill,
                        color: kPrimaryGreen,
                        size: 55,
                      ),
                      title: Text(
                          'Diagnosis: Depression\nMedicine: Anti-Depressants',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      subtitle: Text(
                          "Date: 10/03/2021\n Prescription: 1x3\n Additional Info: Take after a balanced meal",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Source Sans',
                              fontWeight: FontWeight.w600,
                              color: kFieldTextColor)),
                    ),
                  ])),
            ])));
  }
}
