import 'package:e_wallet/Interfaces/home.dart';
import 'package:e_wallet/Interfaces/loading.dart';
import 'package:e_wallet/Interfaces/login.dart';
import 'package:e_wallet/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Interfaces/authenticate.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool userstate = false;

  //FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.idTokenChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;

          print("user : $user");
          if (user == null) {
            return Authenticate();
          } else {
            return Home();
          }
        }
        return Loading();
      },
    );

/*
    if(userstate){
      return Home();
    }else{
      return Login();*/
  }
}
