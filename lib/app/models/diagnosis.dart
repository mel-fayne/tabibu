class Diagnosis {
  int _diagnosisid;
  int _patientid;
  String _disease;
  String _description;
  String _diagnosisdate;
  int _weight;
  int _temperature;
  int _pulserate;
  int _bloodpressure;
  String _symptoms;
  String _medicine;
  String _prescription;
  String _additionaltreatmentinfo;

  Diagnosis(
      this._patientid,
      this._disease,
      this._description,
      this._diagnosisdate,
      this._weight,
      this._temperature,
      this._pulserate,
      this._bloodpressure,
      this._symptoms,
      this._medicine,
      this._prescription,
      this._additionaltreatmentinfo);

  Diagnosis.withId(
      this._diagnosisid,
      this._patientid,
      this._disease,
      this._description,
      this._diagnosisdate,
      this._weight,
      this._temperature,
      this._pulserate,
      this._bloodpressure,
      this._symptoms,
      this._medicine,
      this._prescription,
      this._additionaltreatmentinfo);

  int get diagnosisid => _diagnosisid;
  int get patientid => _patientid;
  String get disease => _disease;
  String get description => _description;
  String get diagnosisdate => _diagnosisdate;
  int get weight => _weight;
  int get temperature => _temperature;
  int get pulserate => _pulserate;
  int get bloodpressure => _bloodpressure;
  String get symptoms => _symptoms;
  String get medicine => _medicine;
  String get prescription => _prescription;
  String get additionaltreatmentinfo => _additionaltreatmentinfo;

  set patientid(int newPatientid) {
    this._patientid = newPatientid;
  }

  set disease(String newDisease) {
    this._disease = newDisease;
  }

  set description(String newDescription) {
    this._description = newDescription;
  }

  set diagnosisdate(String newDiagnosisdate) {
    this._diagnosisdate = newDiagnosisdate;
  }

  set weight(int newWeight) {
    this._weight = newWeight;
  }

  set temperature(int newTemperature) {
    this._temperature = newTemperature;
  }

  set pulserate(int newPulserate) {
    this._pulserate = newPulserate;
  }

  set bloodpressure(int newBloodpressure) {
    this._bloodpressure = newBloodpressure;
  }

  set symptoms(String newSymptoms) {
    this._symptoms = newSymptoms;
  }

  set medicine(String newMedicine) {
    this._medicine = newMedicine;
  }

  set prescription(String newPrescription) {
    this._prescription = newPrescription;
  }

  set additionaltreatmentinfo(String newAdditionaltreatmentinfo) {
    this._additionaltreatmentinfo = newAdditionaltreatmentinfo;
  }

  //Converting a Diagnosis Object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (diagnosisid != null) {
      map['diagnosisid'] = _diagnosisid;
    }

    map['dignosisid'] = _diagnosisid;
    map['disease'] = _disease;
    map['description'] = _description;
    map['diagnosisdate'] = _diagnosisdate;
    map['weight'] = _weight;
    map['temperature'] = _temperature;
    map['pulserate'] = _pulserate;
    map['bloodpressure'] = _bloodpressure;
    map['symptoms'] = _symptoms;
    map['medicine'] = medicine;
    map['prescription'] = _prescription;
    map['additionaltreatmentinfo'] = _additionaltreatmentinfo;

    return map;
  }

  //Extract a Diagnosis Object from a Map object
  Diagnosis.fromMapObject(Map<String, dynamic> map) {
    this._diagnosisid = map['diagnosisid'];
    this._patientid = map['patientid'];
    this._disease = map['disease'];
    this._description = map['description'];
    this._diagnosisdate = map['diagnosisdate'];
    this._weight = map['weight'];
    this._temperature = map['temperature'];
    this._pulserate = map['pulserate'];
    this._bloodpressure = map['bloodpressure'];
    this._symptoms = map['symptoms'];
    this._medicine = map['medicine'];
    this._prescription = map['prescription'];
    this._additionaltreatmentinfo = map['additionaltreatmentinfo'];
  }
}
