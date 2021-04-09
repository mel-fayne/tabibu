import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  static const routeName = "/notifications";
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
        padding: EdgeInsets.only(left: 20),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'PT Serif',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              )),
          ListTile(
            leading: Icon(Icons.notifications_active,
                size: 30, color: kPrimaryGreen),
            title: Text('Appointment Confirmed',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Source Sans',
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            subtitle: Text(
                "Your Appointment scheduled for 23/04/2021 at 0830h at Aga Khan Hospital for your new Patient Request has been confirmed by Dr. Hudson Tisha",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Source Sans',
                    fontWeight: FontWeight.w600,
                    color: kFieldTextColor)),
          ),
          ListTile(
            leading: Icon(Icons.notifications_active,
                size: 30, color: kPrimaryGreen),
            title: Text('Update Seen!',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Source Sans',
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            subtitle: Text(
                "Your medical update sent on 10/03.2021 has been received and reviewd by Dr.Jules Rue",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Source Sans',
                    fontWeight: FontWeight.w600,
                    color: kFieldTextColor)),
          )
        ]),
      ),
    );
  }
}
