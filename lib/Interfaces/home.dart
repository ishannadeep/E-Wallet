import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/Interfaces/loading.dart';
import 'package:e_wallet/Services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String userid = _auth.currentUser.uid;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          var userDocument = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(userDocument['firstname']),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.logout),
                  tooltip: 'Logout',
                  onPressed: () {
                    signout();
                  },
                ),
              ],
            ),
            body: Center(
              child: Container(),
            ),
          );
        });
  }
}
