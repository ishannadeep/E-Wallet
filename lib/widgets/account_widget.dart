import 'dart:ui';
import 'package:e_wallet/Services/string_split.dart';
import 'package:e_wallet/Services/currency_inputformatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Account_widget extends StatefulWidget {
  const Account_widget({Key key}) : super(key: key);

  @override
  _Account_widgetState createState() => _Account_widgetState();
}

class _Account_widgetState extends State<Account_widget> {

  final currency_controller=TextEditingController();
  String _error="";
  final account_key=GlobalKey<FormState>();
  String _account_name;
  String _bank_name;
  String _account_number;
  String _current_amount;

  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    double height_appbar = Scaffold.of(context).appBarMaxHeight;

    Widget updatebottomSheet(){
      showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          backgroundColor: Colors.white,
          context: context, builder: ( context){
        return SingleChildScrollView(
          child: Container(
            //color: Colors.green,
            padding: EdgeInsets.all(10),
            child: Form(
              key: account_key,
                child: Column(
                  children: [
                    Icon(Icons.arrow_drop_down),
                    Text("Drag down to Close"),
                    Container(
                      //color: Colors.red,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                                  ],
                                  validator: (value){
                                    if(value.isEmpty)
                                      return "Empty";
                                    else return null;
                                  },
                                  onSaved: (value)=>_account_name=value,
                                  decoration: InputDecoration(
                                    labelText: "Account name",
                                  ),

                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                                  ],
                                  validator: (value){
                                    if(value.isEmpty)
                                      return "Empty";
                                    else return null;
                                  },
                                  onSaved: (value)=>_bank_name=value,
                                  decoration: InputDecoration(
                                    labelText: "Bank name",
                                  ),

                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value){
                                    if(value.isEmpty)
                                      return "Empty";
                                    else return null;
                                  },
                                  onSaved: (value)=>_account_number=value,
                                  decoration: InputDecoration(
                                    labelText: "Account number",
                                  ),

                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: currency_controller,
                                  inputFormatters: [
                                    CurrencyInputFormatter()

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
                              ),
                            ],
                          ),
                          Text(_error,style: TextStyle(color: Colors.red,fontSize: 20),),
                          Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                      onPressed: (){


                                        account_key.currentState.save();
                                        if(account_key.currentState.validate()){
                                          print("validated");
                                        }
                                      },
                                      child: Text("Submit")
                                  )
                              ),
                            ],),
                        ],),
                    ),
                  ],)
            ),
          ),
        );
      });
    }

    return Stack(
        children:[
            ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context,index){
             return Card(
               color: Colors.indigo,
               child: Theme(
                 data: ThemeData(
                   splashColor: Colors.lightBlueAccent,
                      highlightColor: Colors.lightBlueAccent,
                 ),
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
                    updatebottomSheet();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius:BorderRadiusDirectional.vertical(top: Radius.circular(25)),color: Colors.blue),
                  width: width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Icon(Icons.arrow_drop_up),
                      Text("Drag up to Enter an Account"),
                    ],),
                ),
              ),
            )
    ] );

  }
}
