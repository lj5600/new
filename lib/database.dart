import 'package:newsql/main.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {

  Future<Database>getDataBase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath,'MyDb.db');

    Database database = await openDatabase(path,version: 1,onCreate: (db, version) {
      String table1 = "create table table1 (id integer primary key autoincrement,name Text,email Text,password Text)";
      db.execute(table1);
    },);
    return database;
  }

  Future<bool> insertData(String name, String email, String pass, Database? db) async {

    Database database = Splash.db!;
    String check = "select * from table1 where email = '$email' or password = '$pass'";

    List<Map> list = await database.rawQuery(check);

    if(list.length ==0){

      String insert = "insert into table1 (name,email,password) values ('$name','$email','$pass')";
      int a = await database.rawInsert(insert);
      return true;
    }
    else{
      return false;
    }
  }

  Future<List<Map>> loginUser(String email, String pass) async {
    Database database = Splash.db!;

    String ss = "select * from table1 where email = '$email' and password = '$pass'";
    List<Map> list = await database.rawQuery(ss);
    return list;
  }

  Future<List<Map>> passData(int id) async {
    Database database = Splash.db!;

    String pass = "select * from table1 where id = '$id'";
    List<Map> list = await database.rawQuery(pass);
    print("==list===$list");
    return list;
  }

  Future<List<Map>> viewData(int? id) async {

    Database database = Splash.db!;
    String ss  = "select * from table1 where id = '$id'";
    List<Map> list = await database.rawQuery(ss);
    return list;
  }
}