import 'dart:ui';

import 'package:flutter/material.dart';
class Transaction_widget extends StatefulWidget {
  const Transaction_widget({Key key}) : super(key: key);

  @override
  _Transaction_widgetState createState() => _Transaction_widgetState();
}

class _Transaction_widgetState extends State<Transaction_widget> {
  String dropdownValue = 'To';
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
        bottom: _showBottomMenuebar?0:-height/2.8, //2.53
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
              child: Form(
                child: Container(
                  //color: Colors.black26,
                  color: Colors.white70,
                  width: width,
                  height: height/2.3, //1.94
                  padding: EdgeInsets.all(10),
                  child: Form(
                      child: Column(
                        children: [
                          _showBottomMenuebar?Icon(Icons.arrow_drop_down):Icon(Icons.arrow_drop_up),
                          _showBottomMenuebar?Text("Drag down to Close"):Text("Drag up to Enter an Transaction"),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Amount",
                                  ),

                                ),
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(


                                  child: DropdownButtonFormField<String>(

                                      value: dropdownValue,
                                      icon: Icon(Icons.arrow_drop_down),
                                      //iconSize: 24,
                                      //elevation: 16,
                                    dropdownColor: Colors.white,
                                    decoration: InputDecoration(
                                     // isDense: true,
                                      //hasFloatingPlaceholder: true,
                                      //border: OutlineInputBorder(),
                                      labelText: 'Select To or From',
                                      contentPadding: EdgeInsets.symmetric(vertical: 9.5),
                                    ),

                                  onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                  },
                                  items: <String>['To', 'From']
                                      .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                  );
                                  })
                                      .toList(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                  ),

                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Date",
                                  ),

                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Time",
                                  ),

                                ),
                              ),
                            ],
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
        ),
      )

    ] );
  }
  }
