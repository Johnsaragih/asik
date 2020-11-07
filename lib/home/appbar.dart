import 'package:flutter/material.dart';

class AsikAppBar extends AppBar {
  AsikAppBar()
      : super(
            elevation: 0.25,
            backgroundColor: Colors.teal,
            flexibleSpace: _asikAppBar());

  static Widget _asikAppBar() {
    return new Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "aplikasi system informasi",
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          )
        ],
      ),
    );
  }
}
