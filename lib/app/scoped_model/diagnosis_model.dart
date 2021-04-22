import 'dart:convert';

import 'package:Tabibu/app/models/diagnosis.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class DiagnosisModel extends Model {
  List<Diagnosis> _diagnosis = [];

  //we make a duplicate to avoid messing with the original getter
  List<Diagnosis> get diagnosis {
    return List.from(_diagnosis);
  }

  //function to add a new diagnosis object
  void addDiagnosis(Diagnosis diagnosis) {
    _diagnosis.add(diagnosis);
  }

  //function to fetch the diagnosis objects
  void fetchDiagnosis() {
    http
        .get("http://192.168.0.15/tabibu/api/diagnosis/getdiagnosis.php")
        .then((http.Response response) {
      // print("Fetching data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      final List<Diagnosis> fetchedDiagnosisItems = [];
      /* fetchedData.forEach((data) {
        Diagnosis diagnosis = Diagnosis(
          diagnosisid: data["diagnosis_id"],
          patientid: data["pt_id"],
          disease: data["disease"],
          description: data["description"],
          diagnosisdate: data["diagnosisdate"],
          weight: double.parse(data["weight"]),
          temperature: double.parse(data["temperature"]),
          pulserate: double.parse(data["pulserate"]),
          bloodpressure: double.parse(data["bloodpressure"]),
          symptoms: data["symptoms"],
          medicine: data["medicine"],
          prescription: data["prescription"],
          additionaltreatmentinfo: data["additionaltreatmentinfo"]
        );

        fetchedDiagnosisItems.add(diagnosis);
      }); */
      _diagnosis = fetchedDiagnosisItems;
      print(_diagnosis);
    });
  }
}
