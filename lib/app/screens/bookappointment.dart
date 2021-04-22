import 'package:Tabibu/app/theme/colors.dart';
import 'package:Tabibu/app/theme/my_custom_icons_icons.dart';
import 'package:flutter/material.dart';

class BookAppointment extends StatefulWidget {
  static const routeName = "/bookappointment";

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

Future<TimeOfDay> _selectTime(BuildContext context) async {
  var inititalTime = TimeOfDay.now();
  final TimeOfDay picked = await showTimePicker(
    context: context,
    initialTime: inititalTime,
    confirmText: "Book Now",
    cancelText: "Not Now",
    // initialEntryMode: TimePickerEntryMode.input,
  );
  return picked;
}

Future<void> _selectDate(BuildContext context) async {
  DateTime picked = await showDatePicker(
      context: context,
      cancelText: "Not Now",
      confirmText: "Select Time",
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 90)));
  /* if (picked != null && picked != selectedDate){
      final selectedTimeOfDay=await _selectTime(context);
      if(selectedTimeOfDay !=null){
        print(selectedTimeOfDay);
        picked=new DateTime(picked.year,picked.month,picked.day,selectedTimeOfDay.hour,selectedTimeOfDay.minute);
      } */
  print(picked);
  /*  setState(() {
        selectDateAndCreateRepair(picked);
      });
    } */
}

class _BookAppointmentState extends State<BookAppointment> {
  TextEditingController reasonctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reasonctrl = new TextEditingController();
  }

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 30, bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('Dr.Jules Rue',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'PT Serif',
                            ))),
                    Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 20),
                        child: Text('Doctor ID: D002/3      Dr.License: DN2385',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'PT Serif',
                            ))),
                    Icon(MyCustomIcons.profile_user,
                        size: 80, color: kPrimaryGreen),
                  ]),
            ),
            Text(
              'Select both the time and day of the appointment: ',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Source Sans',
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Container(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    MaterialButton(
                      minWidth: 100,
                      height: 40,
                      onPressed: () {
                        _selectDate(context);
                      },
                      color: kPrimaryGreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("Select Date",
                          style: TextStyle(
                              color: kPrimaryYellow,
                              fontFamily: 'PT Serif',
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Date: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Source Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                )),
            Container(
                padding: EdgeInsets.only(top: 15, bottom: 25),
                child: Row(children: [
                  MaterialButton(
                    minWidth: 100,
                    height: 40,
                    onPressed: () {
                      _selectTime(context);
                    },
                    color: kPrimaryGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text("Select Time",
                        style: TextStyle(
                            color: kPrimaryYellow,
                            fontFamily: 'PT Serif',
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Time: ',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Source Sans',
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ))
                ])),
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: makeInput(
                  label: "Reason for Appointment *",
                  controller: reasonctrl,
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 40,
                onPressed: () {},
                color: kPrimaryGreen,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text("BOOK APPOINTMENT",
                    style: TextStyle(
                        color: kPrimaryYellow,
                        fontFamily: 'PT Serif',
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ])),
    );
  }
}

Widget makeInput({label, required: true, controller}) {
  return Padding(
    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
    child: TextField(
      cursorColor: kPrimaryGreen,
      controller: controller,
      style: TextStyle(
          fontSize: 14,
          fontFamily: 'Source Sans',
          fontWeight: FontWeight.w400,
          color: Colors.black),
      onChanged: (value) {
        debugPrint('something changed in this feld');
        //  diagnosis.patientid = patientidController.text as int;
      },
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'Source Sans',
              fontWeight: FontWeight.w400,
              color: kFieldTextColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    ),
  );
}
