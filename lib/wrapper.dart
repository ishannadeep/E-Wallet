import 'package:e_wallet/Interfaces/home.dart';
import 'package:e_wallet/Interfaces/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool userstate=false;
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    auth
        .authStateChanges()
        .listen((User user) {
          print("usre");
          print(user);
      if (user == null) {
        userstate=false;
      } else {
        userstate=true;
      }
    });
    if(userstate){
      return Home();
    }else{
      return Login();
    }
  }
}
