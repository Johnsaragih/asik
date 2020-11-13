import 'dart:convert';
import 'package:asik/pages/model/model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Personals extends StatefulWidget {
  @override
  _PersonalsState createState() => _PersonalsState();
}

class _PersonalsState extends State<Personals> {
  String userName; 
  String pid='SF13773';
  
  _getpref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString("spNama");
   // pid = pref.getString("spPid");
    setState(() {});
  }

  
  // Future<List<Person>> getanggota() async {
  //   var jsonRespond = await http.get("http://36.78.220.8:3000/Personal/SF13773");
  //   if (jsonRespond.statusCode == 200) {
  //     final jsonItem =
  //         jsonDecode(jsonRespond.body).cast<Map<String, dynamic>>();
  //     List<Person> listanggota = jsonItem.map<Person>((item) {
  //       return Person.fromJson(item);
  //     }).toList();
  //     print(listanggota);
  //     return listanggota;

  //   } else {
  //     throw Exception('Failed to load data from Internet');
  //   }
  // }
  getanggota() async {
    final jsonRespond = await http.get("http://36.78.220.8:3000/Personal/SF13773");
    if (jsonRespond.statusCode == 200) {
      final Map<String,dynamic> data = jsonDecode(jsonRespond.body);
       return data;
    } else {
      throw Exception('Failed to load data from Internet');
    }
  }

  @override
  void initState() {
    _getpref();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userName == null ? "kosong" : 'Absen : ' + userName,
        ),
      ),

      body: Center(
        child: Text("ss"),
      )
    );
  }
}
