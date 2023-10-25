import 'package:flutter/material.dart';
import 'package:newsql/database.dart';
import 'package:newsql/homepage.dart';
import 'package:newsql/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main(){
  runApp(MaterialApp(
    home: Splash(),
  ));
}

class Splash extends StatefulWidget {

  static SharedPreferences? pref;
  static Database? db;

  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  bool isLogin = false;
  String name = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatabaseBefore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("please waiting",style: TextStyle(fontSize: 20),)),
    );
  }

  Future<void> getDatabaseBefore() async {

    Splash.pref = await SharedPreferences.getInstance();

    await Db().getDataBase().then((value) {
      setState(() {
        Splash.db = value;
      });
    });

    setState(() {
      isLogin = Splash.pref!.getBool('login')??false;
    });

    Future.delayed(Duration(seconds: 4)).then((value) {
      if(isLogin){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return HomePage(name,email);
        },));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Login();
        },));
      }
    });
  }
}
