import 'package:flutter/material.dart';
class Home_widget extends StatefulWidget {
  const Home_widget({Key key}) : super(key: key);

  @override
  _Home_widgetState createState() => _Home_widgetState();
}

class _Home_widgetState extends State<Home_widget> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Home_Widget"),);
  }
}
