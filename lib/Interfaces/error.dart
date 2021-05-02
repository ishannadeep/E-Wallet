import 'package:flutter/material.dart';
class FirebaseError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text("ERROR Can't connect to the server.Please check the internet connection",style: TextStyle(fontSize: 20,color: Colors.red),),
      ),
    );
  }
}
