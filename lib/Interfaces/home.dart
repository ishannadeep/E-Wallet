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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading=false;
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home_widget(),
    Transaction_widget(),
    Account_widget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_auth==null){
      print("uid nulll error");
      return Loading();
    }else{
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
           if(snapshot.connectionState == ConnectionState.active){
              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  title: Text(userDocument['firstname']),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.logout),
                      tooltip: 'Logout',
                      onPressed: () async{
                        try {
                          await _auth.signOut();
                          //Navigator.pop(context);
                         Navigator.of(context ).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
                        }catch(e){
                          print("signout error: $e");
                        }
                      },
                    ),
                  ],
                ),
                drawer: user_drawer,
                body:Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
                bottomNavigationBar:bottom_navigation_bar(selectedIndex: _selectedIndex,onItemTapped:_onItemTapped ,),
              );
            }
            return Home_theme();
          });
    }
    }
}
