import 'package:flutter/material.dart';

class MyUpdatesTab extends StatefulWidget {
  static const routeName = "/myupdatestab";

  @override
  _MyUpdatesTabState createState() => _MyUpdatesTabState();
}

class _MyUpdatesTabState extends State<MyUpdatesTab> {
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
