import 'dart:convert';
import 'package:asik/landingpage/landing_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLogin = false;
  String errorMsg = "";
  String nama, bagian,nopid;
  TextEditingController _textPid = TextEditingController();

  void _login(String pid) async {
    final respond = await http.get("http://36.78.220.8:3000/Personal/$pid");
    if (respond.statusCode == 200) {
      final result = jsonDecode(respond.body);
      nama = result["nama"];
      bagian = result["bagian"];
      nopid = result["pid"];
      setState(() { });     
          savePref();
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>LandingPage(),
          ));
          
    } else {
      errorMsg = "Invalid PID";
      setState(() { });
    }
  }
  savePref() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      sp.setString("spNama", nama);
      sp.setString("spBagian", bagian);
      sp.setString("spPid", nopid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60.0, left: 40.0, right: 40.0),
        color: Colors.white,
        child: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 10.0,
                height: 100.0,
                child: Image.asset("assets/launcer.png"),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                validator: (value) => value.isEmpty ? 'PID harus di isi' : null,
                controller: _textPid,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "PID",
                  errorText: errorMsg ?? null,
                  labelStyle: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                ),
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.white)),
                onPressed: () {
                  _login(_textPid.text);
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
