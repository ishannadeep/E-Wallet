import 'package:e_wallet/widgets/drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Home_theme extends StatelessWidget {
  const Home_theme({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout,color: Colors.white,),
          ),
        ],
      ),
      drawer: user_drawer,
      body:Center(
      ),
      bottomNavigationBar: bottom_navigation_bar_theme,
    );
  }
}


var bottom_navigation_bar_theme=BottomNavigationBar(
items: const <BottomNavigationBarItem>[
BottomNavigationBarItem(
icon: Icon(Icons.home_outlined),
label: 'Home',
),
BottomNavigationBarItem(
icon: Icon(Icons.business_rounded),
label: 'Transactions',
),
BottomNavigationBarItem(
icon: Icon(Icons.credit_card_rounded),
label: 'Account',
),
],
currentIndex: 0,
selectedItemColor: Colors.lightBlue,

);

class bottom_navigation_bar extends StatefulWidget {
  int selectedIndex;
  Function onItemTapped;
   bottom_navigation_bar({Key key,this.selectedIndex,this.onItemTapped}) : super(key: key);

  @override
  _bottom_navigation_barState createState() => _bottom_navigation_barState();
}

class _bottom_navigation_barState extends State<bottom_navigation_bar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business_rounded),
          label: 'Transactions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card_rounded),
          label: 'Account',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.lightBlue,
      onTap: widget.onItemTapped,
    );
  }
}
