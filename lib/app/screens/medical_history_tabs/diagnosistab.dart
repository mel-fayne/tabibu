import 'package:flutter/material.dart';

class DiagnosisTab extends StatefulWidget {
  static const routeName = "/diagnosistab";

  @override
  _DiagnosisTabState createState() => _DiagnosisTabState();
}

class _DiagnosisTabState extends State<DiagnosisTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: Container());
  }
}
