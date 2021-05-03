import 'package:e_wallet/Services/services.dart';
import 'package:e_wallet/test.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    print("Homeuuuii");
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            signout();
          },
          child: Text("Log Out"),
        ),
      ),
    );
  }
}
