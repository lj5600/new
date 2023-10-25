
import 'package:flutter/material.dart';
import 'package:newsql/database.dart';
import 'package:newsql/homepage.dart';
import 'package:newsql/main.dart';
import 'package:newsql/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static int? id;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              labelText: "enter password",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),

          ElevatedButton(onPressed: () {

            String passName = "";
            String passEmail = "";

            Db().loginUser(conEmail.text,conPass.text).then((value) {

              Login.id = value[0]['id'];
              print("iddd=====${Login.id}");

              Db().passData(Login.id!).then((value) {

                passName = value[0]['name'];
                passEmail = value[0]['email'];

              });

              if(value.length == 1){
                Splash.pref!.setBool('login', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return HomePage(passName,passEmail);
                },));
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("no user found")));
              }
              
            });

          }, child: Text("login")),

          ElevatedButton(onPressed: () {

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return Signup();
            },));

          }, child: Text("register")),

        ],
      ),
    );
  }
}
