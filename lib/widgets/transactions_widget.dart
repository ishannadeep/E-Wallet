import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:e_wallet/Services/currency_inputformatter.dart';
class Transaction_widget extends StatefulWidget {
  const Transaction_widget({Key key}) : super(key: key);

  @override
  _Transaction_widgetState createState() => _Transaction_widgetState();
}

class _Transaction_widgetState extends State<Transaction_widget> {

  final transaction_key=GlobalKey<FormState>();
  String _dropdownValue = 'To';
  String _error="";
  String _current_amount;
  String _amount;
  String _date;
  String _time;
  String _name;

  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Stack(
      //fit: StackFit.loose,
        children:[
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
                    onTap: () { }
                ),
              ),
            );
          }),
      Positioned(
        bottom:0,
        child: GestureDetector(
          onPanEnd: (details){

            if(details.velocity.pixelsPerSecond.dy<10){

              showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                backgroundColor: Colors.white,
                context: context,
                builder: (context){
                  return SingleChildScrollView(
                    child: Container(
                     // decoration: BoxDecoration(borderRadius:BorderRadiusDirectional.vertical(top: Radius.circular(25)),color: Colors.red),
                      padding: EdgeInsets.all(10),
                      child: Form(
                        key: transaction_key,
                          child: Column(
                            children: [
                              Icon(Icons.arrow_drop_down),
                              Text("Drag down to Close"),
                              Container(
                                //color: Colors.green,
                                child: Column(
                                  children: [

                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(

                                            inputFormatters: [
                                             // FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,2}"))
                                                CurrencyInputFormatter()
                                            ],
                                            validator: (value){
                                              if(value.isEmpty)
                                                return "Empty";
                                              else return null;
                                            },
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
                                              value: _dropdownValue,
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
                                              validator: (value){
                                                if(value.isEmpty)
                                                  return "Empty";
                                                else return null;
                                              },
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  _dropdownValue = newValue;
                                                });
                                              },
                                              onSaved: (value)=>_dropdownValue=value,
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
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                                            ],
                                            validator: (value){
                                              if(value.isEmpty)
                                                return "Empty";
                                              else return null;
                                            },
                                            onSaved: (value)=>_name=value,
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
                                            validator: (value){
                                              if(value.isEmpty)
                                                return "Empty";
                                              else return null;
                                            },
                                            onSaved: (value)=>_date=value,
                                            decoration: InputDecoration(
                                              labelText: "Date",
                                            ),

                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: TextFormField(
                                            validator: (value){
                                              if(value.isEmpty)
                                                return "Empty";
                                              else return null;
                                            },
                                            onSaved: (value)=>_time=value,
                                            decoration: InputDecoration(
                                              labelText: "Time",
                                            ),

                                          ),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]\.[0-9]'))
                                      ],
                                      validator: (value){
                                        if(value.isEmpty)
                                          return "Empty";
                                        else return null;
                                      },
                                      onSaved: (value)=>_current_amount=value,
                                      decoration: InputDecoration(
                                        labelText: "Current amount",
                                      ),

                                    ),
                                    Text(_error,style: TextStyle(color: Colors.red,fontSize: 20),),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: TextButton(
                                                onPressed: (){
                                                  transaction_key.currentState.save();
                                                  if(transaction_key.currentState.validate()){
                                                    print("validated");
                                                  }
                                                },
                                                child: Text("Submit")
                                            )
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  );
                }

              );

            }

          },
          child: Container(
            width: width,
            decoration: BoxDecoration(borderRadius:BorderRadiusDirectional.vertical(top: Radius.circular(25)),color: Colors.blue),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Icon(Icons.arrow_drop_up),
                Text("Drag up to Enter an Transaction"),
              ],
            ),
          ),
        ),
      )

    ] );
  }
  }

