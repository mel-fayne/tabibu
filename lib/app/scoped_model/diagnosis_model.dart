import 'dart:convert';

import 'package:Tabibu/app/models/diagnosis.dart';
import 'package:Tabibu/app/screens/medical_history_tabs/diagnosistab.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class DiagnosisModel extends Model {
  List<Diagnosis> _diagnosis = [];

  //we make a duplicate to avoid messing with the original getter
  List<Diagnosis> get diagnosis {
    return List.from(_diagnosis);
  }

  //functio to add a new diagnosis object
  void addDiagnosis(Diagnosis diagnosis) {
    _diagnosis.add(diagnosis);
  }

  //function to fetch the diagnosis objects
  Future<Null> fetchDiagnosis() {
    //we use the ip address since the phone won't recognise localhost
    return http
        .get("http://192.168.0.15/tabibu/api/diagnosis/getdiagnosis.php")
        .then((http.Response response) {
      // print("Fetching data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      final List<Diagnosis> fetchedDiagnosisItems = [];
      // print(fetchedData);
      /* fetchedData.forEach((diagnosis) {
        Diagnosis diagnosis = Diagnosis(

          diagnosisid: data["diagnosisid"],
          patientid: data["patientid"],
          disease: data["disease"],
          description: data["description"],
          diagnosisdate: data["diagnosisdate"],
          weight: data["weight"],
          temperature: data["temperature"],
          pulserate: data["pulserate"],
          bloodpressure: data["bloodpressure"],
          symptoms: data["symptoms"],
          medicine: data["medicine"],
          prescription: data["prescription"],
          additionaltreatmentinfo: data["additionaltreatmentinfo"],
          
        );

        fetchedDiagnosisItems.add(diagnosis);
      }); */
    });
  }
}
