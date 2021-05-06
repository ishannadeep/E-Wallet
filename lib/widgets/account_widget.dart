import 'dart:ui';

import 'package:flutter/material.dart';
class Account_widget extends StatefulWidget {
  const Account_widget({Key key}) : super(key: key);

  @override
  _Account_widgetState createState() => _Account_widgetState();
}

class _Account_widgetState extends State<Account_widget> {
  bool _showBottomMenuebar=false;
  String _error="";
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Stack(children:[
      ListView.builder(
          itemCount: 6,
          itemBuilder: (context,index){
       return Card(
         color: Colors.indigo,
         child: Theme(
           data: ThemeData(
             splashColor: Colors.lightBlueAccent,
                highlightColor: Colors.lightBlueAccent,
            // backgroundColor: Colors.indigo

           )
           ,
           child: ListTile(
                title: Text("First item",style: TextStyle(color: Colors.white),),




            // visualDensity:VisualDensity(horizontal: 10),


               onTap: () { print("hello");}
            ),
         ),
       );
      }),
      AnimatedOpacity(
        duration: Duration(milliseconds: 250),
        opacity:_showBottomMenuebar?1.0:0,
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
      child: Container(
        color: Colors.black.withOpacity(0.2),
      ),
      ),

      ),
      AnimatedPositioned(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 250),
        bottom: _showBottomMenuebar?0:-height/2.8,
        child: SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            child: GestureDetector(
              onPanEnd: (details){

                if(details.velocity.pixelsPerSecond.dy<10){
                  setState(() {
                    _showBottomMenuebar=true;
                  });

                }else if(details.velocity.pixelsPerSecond.dy>10){
                  setState(() {
                    _showBottomMenuebar=false;
                  });

                }

              },
              child: Container(
                //color: Colors.black26,
                color: Colors.white70,
                width: width,
                height: height/3+80,
                padding: EdgeInsets.all(10),
                child: Form(
                    child: Column(
                      children: [
                        _showBottomMenuebar?Icon(Icons.arrow_drop_down):Icon(Icons.arrow_drop_up),
                        _showBottomMenuebar?Text("Drag down to Close"):Text("Drag up to Enter an Account"),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Account name",
                                ),

                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Bank name",
                                ),

                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Account number",
                          ),

                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Current amount",
                          ),

                        ),
                        Text(_error,style: TextStyle(color: Colors.red,fontSize: 20),),
                        Expanded(child: TextButton(onPressed: (){}, child: Text("Submit"))),

                      ],
                    )
                ),
              ),
            ),
          ),
        ),
      )

    ] );
  }
}
