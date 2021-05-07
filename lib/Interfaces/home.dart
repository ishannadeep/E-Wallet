import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/Interfaces/loading.dart';
import 'package:e_wallet/Services/services.dart';
import 'package:e_wallet/widgets/account_widget.dart';
import 'package:e_wallet/widgets/drawer_widget.dart';
import 'package:e_wallet/widgets/home_widget.dart';
import 'package:e_wallet/widgets/transactions_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'error.dart';
import 'home_theme.dart';
import 'login.dart';
import 'package:e_wallet/widgets/home_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    if (_auth == null) {
      print("uid nulll error");
      return Loading();
    } else {
      String userid = _auth.currentUser.uid;
      return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            var userDocument = snapshot.data;
            if (snapshot.hasError) {
              return FirebaseError();
            }
            if (snapshot.connectionState == ConnectionState.active) {
              return HomeSecond(
                user: userDocument['firstname'],
              );
            }
            return Home_theme();
          });
    }
  }
}
