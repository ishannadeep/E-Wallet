import 'package:e_wallet/Interfaces/login.dart';
import 'package:e_wallet/Interfaces/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showAuthUi = true;

  void toggleView() {
    setState(() {
      showAuthUi = !showAuthUi;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showAuthUi) {
      return Login(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
