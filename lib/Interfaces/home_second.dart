import 'package:e_wallet/widgets/account_widget.dart';
import 'package:e_wallet/widgets/drawer_widget.dart';
import 'package:e_wallet/widgets/home_widget.dart';
import 'package:e_wallet/widgets/transactions_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class HomeSecond extends StatefulWidget {
  final String user;

  const HomeSecond({Key key, this.user}) : super(key: key);

  @override
  _HomeSecondState createState() => _HomeSecondState();
}

class _HomeSecondState extends State<HomeSecond> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  PageController _pageController;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home_widget(),
    Transaction_widget(),
    Account_widget()
  ];
  @override
  void initState(){
    _pageController =  new PageController(
      initialPage: _selectedIndex,
    );
    super.initState();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      this._pageController.animateToPage(_selectedIndex,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset : false,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.user),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () async {
                try {
                  await _auth.signOut();
                  //Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Login()));
                } catch (e) {
                  print("signout error: $e");
                }
              },
            ),
          ],
        ),
        drawer: user_drawer,
        body: PageView(
            controller: _pageController,
          onPageChanged: (newPage){
            setState((){
              this._selectedIndex=newPage;
            });
          },
          children:[
            Center(
              child: Home_widget(),
            ),
            Center(
              child: Transaction_widget(),
            ),
            Center(
              child:Account_widget(),
            ),
          ]
        ),
        bottomNavigationBar: bottom_navigation_bar(
          selectedindex: _selectedIndex,
          ontapped: _onItemTapped,
        ));
  }
}
class bottom_navigation_bar extends StatefulWidget {
  int selectedindex;
  Function ontapped;

  bottom_navigation_bar({Key key, this.ontapped, this.selectedindex})
      : super(key: key);

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
      currentIndex: widget.selectedindex,
      selectedItemColor: Colors.lightBlue,
      onTap: widget.ontapped,
    );
  }
}


class Home_theme extends StatelessWidget {
  const Home_theme({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: user_drawer,
      body: Center(),
      bottomNavigationBar: bottom_navigation_bar_theme,
    );
  }
}

var bottom_navigation_bar_theme = BottomNavigationBar(
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


