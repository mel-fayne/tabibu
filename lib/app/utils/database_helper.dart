import 'package:Tabibu/app/models/diagnosis.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String diagnosisTable = 'diagnosis_table';
  String colDiagnosisid = 'diagnosisid';
  String colPatientid = 'patientid';
  String colDisease = 'disease';
  String colDescription = 'description';
  String colDiagnosisdate = 'diagnosisdate';
  String colWeight = 'weight';
  String colTemperature = 'temperature';
  String colPulserate = 'pulserate';
  String colBloodpressure = 'bloodpressure';
  String colSymptoms = 'symptoms';
  String colMedicine = 'medicine';
  String colPrescription = 'prescription';
  String colAdditionaltreatmentinfo = 'additionaltreatmentinfo';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'tabibu.db';

    // Open/create the database at a given path
    var tabibuDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return tabibuDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $diagnosisTable($colDiagnosisid INTEGER PRIMARY KEY AUTOINCREMENT, $colPatientid INTEGER, $colDisease TEXT, $colDescription TEXT, $colDiagnosisdate TEXT, $colWeight INTEGER, $colTemperature INTEGER, $colPulserate INTEGER, $colBloodpressure INTEGER, $colSymptoms TEXT, $colMedicine TEXT, $colPrescription TEXT, $colAdditionaltreatmentinfo TEXT,)');
  }

  // Fetch Operation: Get all diagnosis objects from database
  Future<List<Map<String, dynamic>>> getDiagnosisMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $diagnosisTable order by $colPriority ASC');
    var result = await db.query(diagnosisTable, orderBy: '$colDiagnosisid ASC');
    return result;
  }

  // Insert Operation: Insert a Diagnosis object to database
  Future<int> insertDiagnosis(Diagnosis diagnosis) async {
    Database db = await this.database;
    var result = await db.insert(diagnosisTable, diagnosis.toMap());
    return result;
  }

  // Update Operation: Update a Diagnosis object and save it to database
  Future<int> updateDiagnosis(Diagnosis diagnosis) async {
    var db = await this.database;
    var result = await db.update(diagnosisTable, diagnosis.toMap(),
        where: '$colDiagnosisid = ?', whereArgs: [diagnosis.diagnosisid]);
    return result;
  }

  // Delete Operation: Delete a Diagnosis object from database
  Future<int> deleteDiagnosis(int id) async {
    var db = await this.database;
    int result = await db
        .rawDelete('DELETE FROM $diagnosisTable WHERE $colDiagnosisid = $id');
    return result;
  }

  // Get number of Diagnosis objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $diagnosisTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Diagnosis List' [ List<Diagnosis> ]
  Future<List<Diagnosis>> getDiagnosisList() async {
    var diagnosisMapList =
        await getDiagnosisMapList(); // Get 'Map List' from database
    int count =
        diagnosisMapList.length; // Count the number of map entries in db table

    List<Diagnosis> diagnosisList = List<Diagnosis>();
    // For loop to create a 'Diagnosis List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      diagnosisList.add(Diagnosis.fromMapObject(diagnosisMapList[i]));
    }

    return diagnosisList;
  }
}
