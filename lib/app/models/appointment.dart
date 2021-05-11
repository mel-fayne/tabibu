class Appointment {
  final String apptid;
  final String patientid;
  final String doctorid;
  final String date;
  final String time;
  final String location;
  final String reason;
  final String status;
  final String drname;
  final String ptname;

  Appointment(
      this.date,
      this.doctorid,
      this.location,
      this.patientid,
      this.reason,
      this.time,
      this.apptid,
      this.drname,
      this.status,
      this.ptname);
}
