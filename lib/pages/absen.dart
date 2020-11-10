import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Absen extends StatefulWidget {
  @override
  _AbsenState createState() => _AbsenState();
}

class _AbsenState extends State<Absen> {
  String userName;
  String pid;
  String tahun;

  _getpref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString("spNama");
    pid = pref.getString("spPid");
    setState(() {});
  }

  _getdate() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var thn = "${dateParse.year}";
    setState(() {
      tahun = thn.toString();
    });
  }

  Future<List> getabsen(String pid, String tahun) async {
    final respond = await http.get("http://36.78.220.8:3000/Absen/$pid/$tahun");
    if (respond.statusCode == 200) {
      print(pid);
      return jsonDecode(respond.body);
    } else {
      throw Exception('Failed load data');
    }
  }

  @override
  void initState() {
    _getdate();
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
      body: FutureBuilder<List>(
          future: getabsen(pid, tahun),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.hasError);
            return snapshot.hasData
                ? new DataAbsen(
                    listabsen: snapshot.data,
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class DataAbsen extends StatelessWidget {
  final List listabsen;
  DataAbsen({this.listabsen});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listabsen == null ? 0 : listabsen.length,
      itemBuilder: (context, i) {
        return Container(
          child: Card(
            child: ListTile(
              title: Text(
                'Tgl ' + listabsen[i]['tgl'].substring(0, 10),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              subtitle: Text(
                'Jenis: ' + listabsen[i]['jenis'],
                style: TextStyle(fontSize: 16.0, color: Colors.blue[900]),
              ),
            ),
          ),
        );
      },
    );
  }
}
