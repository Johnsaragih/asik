import 'package:flutter/material.dart';

class AsikService {
  IconData image;
  Color warna;
  String judul;
  AsikService({this.image, this.warna, this.judul});
}

class Gambar {
  Function onPress;
  String judul;
  String image;

  Gambar({this.judul, this.onPress, this.image});
}
