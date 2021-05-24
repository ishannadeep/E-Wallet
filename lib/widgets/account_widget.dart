import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/Services/currency_manupulation.dart';
import 'package:e_wallet/Services/custom_inputformatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Account_widget extends StatefulWidget {
  const Account_widget({Key key}) : super(key: key);

  @override
  _Account_widgetState createState() => _Account_widgetState();
}

class _Account_widgetState extends State<Account_widget> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  final currency_controller=TextEditingController();
  String _error="";
  final account_key=GlobalKey<FormState>();
  String _account_name;
  String _bank_name;
  String _account_number;
  String _current_amount;
  String _card_type;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference _users = FirebaseFirestore.instance.collection(_auth.currentUser.uid+"account");

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
                                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]|\s'))
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
                                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]|\s'))
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
                          /*
                          Row(
                            children: [
                              Column(
                                children: [
                                  Radio(value: "visa", groupValue: _card_type, onChanged: (value){_card_type=value;}),
                                  Image(image: AssetImage("images/visa_logo.png"),width: 195,height: 30,)
                                ],
                              ),
                              Column(
                                children: [
                                  Radio(value: "visa", groupValue: _card_type, onChanged: (value){_card_type=value;}),
                                  Image(image: AssetImage("images/master_logo.png"),width: 195,height: 30,)
                                ],
                              )
                            ],
                          ),*/
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
                                  onSaved: (value)=>_current_amount=currencyFormatter(value),
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
                                        print("_current_amount : $_current_amount");
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

    return Column(

        children:[
            Expanded(
              flex: 8,
              child: Container(

                width: width,
                //height: height-200,
                child: ListView.builder(

                    //physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context,index){
                 return Card(
                   color: Colors.indigo,
                   child: Theme(
                     data: ThemeData(
                       splashColor: Colors.lightBlueAccent,
                          highlightColor: Colors.lightBlueAccent,
                       selectedRowColor: Colors.black
                     ),
                     child: ExpansionTile(
                         title: Text("ACC Name",style: TextStyle(color: Colors.white),),
                         subtitle: Text("Bank name ",style: TextStyle(color: Colors.white),),
                         trailing: Text("Current Amount:20000.00",style: TextStyle(color: Colors.white,fontSize: 20),),
                         children: [

                           Text("Acc:1054396458",style: TextStyle(color: Colors.white,fontSize: 20),),


                         ],
                      ),
                   ),
                 );
                }),
              ),
            ),

            Expanded(
              flex: 1,
              child: GestureDetector(
                onPanEnd: (details){
                  if(details.velocity.pixelsPerSecond.dy<10){
                    updatebottomSheet();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius:BorderRadiusDirectional.vertical(top: Radius.circular(25)),color: Colors.blue),
                  width: width,
                  //height: 60,
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
