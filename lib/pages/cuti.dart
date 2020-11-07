import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cuti extends StatefulWidget {
  @override
  _CutiState createState() => _CutiState();
}

class _CutiState extends State<Cuti> {
  String userName;
  String namaBag;

    _getpref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString("spNama");
      namaBag = pref.getString("spBagian");
     print(userName);
    });
  }
  @override
  void initState() {
    super.initState();
    _getpref();
     
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("ini halaman cuti"),
      ),
      body: Center(
        child: Text(userName==null ? "kosong" : userName,style: TextStyle(fontSize: 50.0),),
      ),
    );
  }
}
