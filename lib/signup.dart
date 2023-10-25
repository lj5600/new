import 'package:flutter/material.dart';
import 'package:newsql/database.dart';
import 'package:newsql/login.dart';
import 'package:newsql/main.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController conName = TextEditingController();
  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: conName,
            decoration: InputDecoration(
              labelText: "enter name",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),

          SizedBox(height: 20,),

          TextField(
            controller: conEmail,
            decoration: InputDecoration(
              labelText: "enter email",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),

          SizedBox(height: 20,),

          TextField(
            controller: conPass,
            decoration: InputDecoration(
              labelText: "enter pass",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),


          ElevatedButton(onPressed: () {

            String name = conName.text;
            String email = conEmail.text;
            String pass = conPass.text;

            Db().insertData(name,email,pass,Splash.db).then((value) {
              if(value){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("register successful")));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Login();
                },));
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("user already exists")));
              }
            });

          }, child: Text("signup")),
        ],
      ),
    );
  }
}
