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
