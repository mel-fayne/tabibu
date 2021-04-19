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

//maybe use query in line 55
  void _createDb(Database db, int newVersion) async {
    await db.query(''' 
        CREATE TABLE $diagnosisTable(
          $colDiagnosisid INTEGER PRIMARY KEY AUTOINCREMENT, 
          $colPatientid INTEGER, $colDisease TEXT, $colDescription TEXT, 
          $colDiagnosisdate TEXT, 
          $colWeight INTEGER, $colTemperature INTEGER, 
          $colPulserate INTEGER, $colBloodpressure INTEGER, 
          $colSymptoms TEXT, $colMedicine TEXT, 
          $colPrescription TEXT, $colAdditionaltreatmentinfo TEXT)
          ''');
  }
  /*
  await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
				'$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  */

  // Fetch Operation: Get all diagnosis objects from database
  Future<List<Map<String, dynamic>>> getDiagnosisMapList() async {
    Database db = await this.database;
    //var result = await db.rawQuery('SELECT * FROM $diagnosisTable order by $colPriority ASC');
    var result =
        await db.query(diagnosisTable, orderBy: '$colDiagnosisdate DESC');
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

/*   // Delete Operation: Delete a Diagnosis object from database
  Future<int> deleteDiagnosis(int id) async {
    var db = await this.database;
    int result = await db
        .rawDelete('DELETE FROM $diagnosisTable WHERE $colDiagnosisid = $id');
    return result;
  } */

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

/* 
E/SQLiteLog(28455): (1) near "CREATE": syntax error
I/flutter (28455): error DatabaseException(near "CREATE": syntax error (code 1 SQLITE_ERROR[1]): , while compiling: SELECT * FROM         CREATE TABLE diagnosis_table(
I/flutter (28455):           diagnosisid INTEGER PRIMARY KEY AUTOINCREMENT,
I/flutter (28455):           patientid INTEGER, disease TEXT, description TEXT,
I/flutter (28455):           diagnosisdate TEXT,
I/flutter (28455):           weight INTEGER, temperature INTEGER,
I/flutter (28455):           pulserate INTEGER, bloodpressure INTEGER, 
I/flutter (28455):           symptoms TEXT, medicine TEXT,
I/flutter (28455):           prescription TEXT, additionaltreatmentinfo TEXT)) sql 'SELECT * FROM         CREATE TABLE diagnosis_table(
I/flutter (28455):           diagnosisid INTEGER PRIMARY KEY AUTOINCREMENT,
I/flutter (28455):           patientid INTEGER, disease TEXT, description TEXT,
I/flutter (28455):           diagnosisdate TEXT,
I/flutter (28455):           weight INTEGER, temperature INTEGER,
I/flutter (28455):           pulserate INTEGER, bloodpressure INTEGER,
I/flutter (28455):           symptoms TEXT, medicine TEXT,
I/flutter (28455):           prescription TEXT, additionaltreatmentinfo TEXT)
I/flutter (28455):           ' args []} during open, closing...
E/flutter (28455): [ERROR:flutter/lib/ui/ui_dart_state.cc(177)] Unhandled Exception: DatabaseException(near "CREATE": syntax error (code 1 SQLITE_ERROR[1]): , while compiling: SELECT * FROM         CREATE TABLE diagnosis_table(
E/flutter (28455):           diagnosisid INTEGER PRIMARY KEY AUTOINCREMENT, 
E/flutter (28455):           patientid INTEGER, disease TEXT, description TEXT,
E/flutter (28455):           diagnosisdate TEXT,
E/flutter (28455):           weight INTEGER, temperature INTEGER,
E/flutter (28455):           pulserate INTEGER, bloodpressure INTEGER, 
E/flutter (28455):           symptoms TEXT, medicine TEXT,
E/flutter (28455):           prescription TEXT, additionaltreatmentinfo TEXT)) sql 'SELECT * FROM         CREATE TABLE diagnosis_table(
E/flutter (28455):           diagnosisid INTEGER PRIMARY KEY AUTOINCREMENT,
E/flutter (28455):           patientid INTEGER, disease TEXT, description TEXT,
E/flutter (28455):           diagnosisdate TEXT,
E/flutter (28455):           weight INTEGER, temperature INTEGER,
E/flutter (28455):           pulserate INTEGER, bloodpressure INTEGER,
E/flutter (28455):           symptoms TEXT, medicine TEXT, 
E/flutter (28455):           prescription TEXT, additionaltreatmentinfo TEXT)
E/flutter (28455):           ' args []}
E/flutter (28455): #0      wrapDatabaseException (package:sqflite/src/exception_impl.dart:11:7)
E/flutter (28455): <asynchronous suspension>
E/flutter (28455): #1      SqfliteDatabaseFactoryImpl.wrapDatabaseException (package:sqflite/src/factory_impl.dart:78:7)
E/flutter (28455): #2      SqfliteDatabaseMixin.safeInvokeMethod (package:sqflite_common/src/database_mixin.dart:211:15)
E/flutter (28455): #3      SqfliteDatabaseMixin.txnRawQuery.<anonymous closure> (package:sqflite_common/src/database_mixin.dart:403:36)
E/flutter (28455): #4      SqfliteDatabaseMixin.txnSynchronized (package:sqflite_common/src/database_mixin.dart:321:26)
E/flutter (28455): #5      SqfliteDatabaseMixin.txnRawQuery (package:sqflite_common/src/database_mixin.dart:402:12)
E/flutter (28455): #6      SqfliteDatabaseExecutorMixin._rawQuery (package:sqflite_common/src/database_mixin.dart:126:15)
E/flutter (28455): #7      SqfliteDatabaseExecutorMixin.query (package:sqflite_common/src/database_mixin.dart:110:12)
E/flutter (28455): #8      DatabaseHelper._createDb (package:Tabibu/app/utils/database_helper.dart:56:14)
E/flutter (28455): #9      SqfliteDatabaseMixin.doOpen.<anonymous closure> (package:sqflite_common/src/database_mixin.dart:718:39)
E/flutter (28455): <asynchronous suspension>
E/flutter (28455): #10     SqfliteDatabaseMixin.doOpen.<anonymous closure> (package:sqflite_common/src/database_mixin.dart)
E/flutter (28455): #11     SqfliteDatabaseMixin._runTransaction (package:sqflite_common/src/database_mixin.dart:486:28)
E/flutter (28455): <asynchronous suspension>
E/flutter (28455): #12     SqfliteDatabaseMixin.transaction.<anonymous closure> (package:sqflite_common/src/database_mixin.dart:503:14)
E/flutter (28455): #13     SqfliteDatabaseMixin.txnSynchronized (package:sqflite_common/src/database_mixin.dart:321:26)
E/flutter (28455): #14     SqfliteDatabaseMixin.txnWriteSynchronized (package:sqflite_common/src/database_mixin.dart:354:7)
E/flutter (28455): #15     SqfliteDatabaseMixin.transaction (package:sqflite_common/src/database_mixin.dart:502:12)
E/flutter (28455): #16     SqfliteDatabaseMixin.doOpen (package:sqflite_common/src/database_mixin.dart:708:17)
E/flutter (28455): <asynchronous suspension>
E/flutter (28455): #17     SqfliteDatabaseOpenHelper.openDatabase (package:sqflite_common/src/database.dart:44:22)
E/flutter (28455): #18     SqfliteDatabaseFactoryMixin.openDatabase.<anonymous closure> (package:sqflite_common/src/factory_mixin.dart:128:43)        
E/flutter (28455): #19     ReentrantLock.synchronized.<anonymous closure>.<anonymous closure> (package:synchronized/src/reentrant_lock.dart:35:24)    
E/flutter (28455): #20     _rootRun (dart:async/zone.dart:1190:13)
E/flutter (28455): #21     _CustomZone.run (dart:async/zone.dart:1093:19)
E/flutter (28455): #22     _runZoned (dart:async/zone.dart:1630:10)
E/flutter (28455): #23     runZoned (dart:async/zone.dart:1550:10)
E/flutter (28455): #24     ReentrantLock.synchronized.<anonymous closure> (package:synchronized/src/reentrant_lock.dart:34:24)
E/flutter (28455): #25     BasicLock.synchronized (package:synchronized/src/basic_lock.dart:32:26)
E/flutter (28455): #26     ReentrantLock.synchronized (package:synchronized/src/reentrant_lock.dart:30:17)
E/flutter (28455): #27     SqfliteDatabaseFactoryMixin.openDatabase (package:sqflite_common/src/factory_mixin.dart:96:17)
E/flutter (28455): <asynchronous suspension>
E/flutter (28455): #28     openDatabase (package:sqflite/sqflite.dart:145:26)
E/flutter (28455): #29     DatabaseHelper.initializeDatabase (package:Tabibu/app/utils/database_helper.dart:50:15)
E/flutter (28455): <asynchronous suspension>
E/flutter (28455): #30     DatabaseHelper.database (package:Tabibu/app/utils/database_helper.dart:38:25)
E/flutter (28455): #31     DatabaseHelper.inse
*/
