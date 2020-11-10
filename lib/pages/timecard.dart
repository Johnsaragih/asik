import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Timecard extends StatefulWidget {
  @override
  _TimecardState createState() => _TimecardState();
}

class _TimecardState extends State<Timecard> {
  String userName;
  String pid;
  String bulan;
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
    var bln = "${dateParse.month}";
    var thn = "${dateParse.year}";
    setState(() {
      bulan = bln.toString();
      tahun = thn.toString();
    });
  }

  Future<List> gettimecard(String pid, String bulan, String tahun) async {
    final respond =
        await http.get("http://36.78.220.8:3000/Timecard/$pid/$bulan/$tahun");
    if (respond.statusCode == 200) {
      print(pid);
      return jsonDecode(respond.body);
    } else {
      throw Exception('Failed load data');
    }
  }

  @override
  void initState() {
    _getpref();
    _getdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userName == null ? "kosong" : 'Timecard : ' + userName,
        ),
      ),
      body: FutureBuilder<List>(
          future: gettimecard(pid, bulan, tahun),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.hasError);
            return snapshot.hasData
                ? new TCpersonal(
                    listtimecard: snapshot.data,
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class TCpersonal extends StatelessWidget {
  final List listtimecard;
  TCpersonal({this.listtimecard});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listtimecard == null ? 0 : listtimecard.length,
      itemBuilder: (context, i) {
        return Container(
          child: Card(
            child: ListTile(
              title: Text(
                'Tgl ' + listtimecard[i]['tgl'].substring(0, 10),
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),
              ),
              subtitle: Text('MSK: ' +
                  listtimecard[i]['checkin'] +
                  ' PLG: ' +
                  listtimecard[i]['checkout'] +
                  ' OVT: ' +
                  listtimecard[i]['overtime'].toString(), style: TextStyle(fontSize: 16.0,color: Colors.blue[900]),),
            ),
          ),
        );
      },
    );
  }
}
