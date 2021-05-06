import 'package:e_wallet/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Interfaces/error.dart';
import 'Interfaces/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<FirebaseApp>(
          // Initialize FlutterFire:
          stream: _initialization.asStream(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return FirebaseError();
            }
            if(snapshot.connectionState == ConnectionState.none){
              return FirebaseError();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              // return Provider_validator();
              return Wrapper();
            }
            return Loading();
          }
          // Otherwise, show something whilst waiting for initialization to complete

          ),
    );
  }
}
