import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class SingleDiagnosis extends StatelessWidget {
  static const routeName = "/singlediagnosis";
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'More Diagnosis Deatails',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'PT Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Diagnosis Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.details,
                            color: kPrimaryGreen,
                            size: 16,
                          ))
                    ],
                  ),
                  Text(
                    'Diagnosis ID: M003/1  Date: 10/03/2021\nDoctor Name: Dr.Jules Rue  Doctor ID: D002/2\nDiagnosis: Depression\nTreatment: Anti-depressants\nVitals:\nBody Temperature: 36 C\nBlood Pressure: 68mmHg\nBreathing Rate: 25 breaths per min\nBody Weight: 56kg',
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
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Diagnosis Symptoms',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.sick,
                            color: kPrimaryGreen,
                            size: 16,
                          ))
                    ],
                  ),
                  Text(
                    'Shortness of Breath\nLoss of Appetitie\nDizziness',
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
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Diagnosis Description',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.description,
                            color: kPrimaryGreen,
                            size: 16,
                          ))
                    ],
                  ),
                  Text(
                    "We noted an improvement in John's drinking habits. He has a more postive outlook and the treatment is taking effect as expected",
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
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Diagnosis Treatment',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Source Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            MyCustomIcons.pill,
                            color: kPrimaryGreen,
                            size: 16,
                          ))
                    ],
                  ),
                  Text(
                    "Medicine: Antidepressants\nPrescription: 1x3\nAdditional Treatment Info: Take after a balanced meal",
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
          ],
        ),
      ),
    );
  }
}
