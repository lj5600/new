import 'package:flutter/material.dart';
import 'package:newsql/database.dart';
import 'package:newsql/main.dart';
import 'login.dart';

class HomePage extends StatefulWidget {

  String passName;
  String passEmail;
  HomePage( this.passName, this.passEmail);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String name = "";
  String email = "";
  String userid = "";
  String number = "";

  TextEditingController conUser = TextEditingController();
  TextEditingController conNum = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {

            Splash.pref!.setBool('login', false);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return Login();
            },));

          }, icon: Icon(Icons.logout)),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("name : ${widget.passName}",style: TextStyle(fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("email : ${widget.passEmail}",style: TextStyle(fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Text("userid : ",style: TextStyle(fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("number : ",style: TextStyle(fontSize: 20),),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {

        showDialog(context: context, builder: (context) {
          return SimpleDialog(
            children: [
              TextField(
                controller: conUser,
                decoration: InputDecoration(
                  labelText: "enter userid",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              TextField(
                controller: conNum,
                decoration: InputDecoration(
                  labelText: "enter number",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              TextButton(onPressed: () {

              }, child: Text("ok")),
            ],
          );
        },);

      },
        child: Icon(Icons.add),
      ),
    );
  }

  void view() {
    Db().viewData(Login.id).then((value) {

      setState(() {
        name = value[0]['name'];
        email = value[0]['email'];
      });
    });
  }
}
