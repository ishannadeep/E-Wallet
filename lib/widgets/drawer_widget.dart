import 'package:flutter/material.dart';
var user_drawer=Drawer(
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('User Profile'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('Update User Info'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: Text('About'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
    ],
  ),
);