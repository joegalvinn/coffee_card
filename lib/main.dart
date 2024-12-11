import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
            title: const Center(child: Text("This Is My First App!!")),
            backgroundColor: Colors.amber[900]), //AppBar
        body: const Center(child: Text("hello, Joe"))),
  ));
}
