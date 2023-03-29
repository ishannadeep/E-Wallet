import 'dart:ui';
import 'package:e_wallet/Services/currency_manupulation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:e_wallet/Services/custom_inputformatter.dart';
class TransactionWidget extends StatefulWidget {
  const TransactionWidget({Key key}) : super(key: key);

  @override
  _TransactionWidgetState createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  final transactionKey=GlobalKey<FormState>();
  final dateController=TextEditingController();
  final timeController=TextEditingController();
  String _dropdownValue = 'To';
  String _error="";
  String currentAmount;
  String _amount;
  String _date;
  String _time;
  String _name;
  DateTime _currentDate;
  TimeOfDay _currentTime;
  Future<Null> datePicker(BuildContext context) async {
    String month;
    String day;
    String year;
    _currentDate = DateTime.now();
    final DateTime _picked = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate:DateTime(2000),
        lastDate: _currentDate);
    if (_picked != null ) {

        year = _picked.year.toString();
        month = _picked.month.toString();
        day = _picked.day.toString();
        dateController.text = day + "-" + month + "-" + year;

    }
  }
  Future timepicker(BuildContext context)async{
    String hour;
    String minute;
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 7, minute: 15),
    );
    if (newTime != null ) {

        hour = newTime.hour.toString();
        minute = newTime.minute.toString();

        timeController.text = hour + ":" + minute;


    }
  }
@override
void initState() {
    // TODO: implement initState
    super.initState();
    _currentDate = DateTime.now();
    _currentTime=TimeOfDay.now();
    dateController.text =_currentDate.day.toString()+"-"+_currentDate.month.toString()+"-"+_currentDate.year.toString();
    timeController.text=_currentTime.hour.toString()+":"+_currentTime.minute.toString();
  }
  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Column(
      //fit: StackFit.loose,
        children:[
      Expanded(
        flex: 8,
        child: Container(
          width: width,
          child: ListView.builder(
              itemCount: 12,
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
                    child: ExpansionTile(
                      title: Text("To:Barclays",style: TextStyle(color: Colors.white),),
                      subtitle: Text("12:56 , 12-05-2020 ",style: TextStyle(color: Colors.white),),
                      trailing: Text("Amount:20000.00",style: TextStyle(color: Colors.white,fontSize: 20),),
                      children: [
                        Text("Account name",style: TextStyle(color: Colors.white,fontSize: 20),),
                        Text("Acc:1054396458",style: TextStyle(color: Colors.white,fontSize: 20),),
                        Text("Bank name",style: TextStyle(color: Colors.white,fontSize: 20),),

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
                        key: transactionKey,
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
                                            onSaved: (value)=>_amount=currencyFormatter(value),
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
                                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]|\s'))
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
                                              RegExp exp=RegExp(r'^((0[1-9]|[12]\d|3[01]|[1-9])-(0[1-9]|1[0-2]|[1-9])-([12]\d{3}))$');
                                              if(value.isEmpty)
                                                return "Empty";
                                              else return null;
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(r'^(([1-9]|[12]\d|3[01])-([1-9]|1[0-2])-([12]\d{3}))$|^[0-9]$|^([012]\d|3[01])$|^([0-9]-)$|^([012]\d-|3[01]-)$|^([1-9]|[12]\d|3[01])-([1-9]|0[1-9]|1[0-2])$|^([1-9]|[12]\d|3[01])-([1-9]|0[1-9]|1[0-2])-$|^([1-9]|[12]\d|3[01])-([1-9]|0[1-9]|1[0-2])-([12])$|^([1-9]|[12]\d|3[01])-([1-9]|0[1-9]|1[0-2])-([12]\d{0,3})$'))

                                            ],
                                            //enabled: false,
                                            controller: dateController,
                                            onSaved: (value)=>_date=value,
                                            decoration: InputDecoration(
                                              labelText: "Date",
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.calendar_today),
                                                onPressed:(){datePicker(context);} ,
                                              )
                                            ),

                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: TextFormField(



                                            validator: (value){
                                              RegExp exp=RegExp(r'^((0[0-9]|[0-9]|[2][0-3]|1[0-9]):([1-9]|[1-5][0-9]|0[0-9]))$');
                                              if(value.isEmpty)
                                                return "Empty";
                                              else if(!exp.hasMatch(value))
                                                return "Invalid Format";
                                              else return null;

                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(r'^[1-9]$|^0[1-9]$|^[01][0-9]$|^[012][0-3]:$|^[2][0-3]$|^[012][0-3]:[0-5]$|^[012][0-3]:[1-9]$|^[012][0-3]:[0-5][0-9]$'))

                                            ],

                                            controller: timeController,

                                            onSaved: (value)=>_time=value,

                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                icon:Icon(Icons.access_time),
                                                onPressed: (){timepicker(context);},

                                              ),

                                              labelText: "Time",
                                            ),

                                          ),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      inputFormatters: [
                                        CurrencyInputFormatter()
                                      ],
                                      validator: (value){
                                        if(value.isEmpty)
                                          return "Empty";
                                        else return null;
                                      },
                                      onSaved: (value)=>currentAmount=currencyFormatter(value),
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
                                                  transactionKey.currentState.save();
                                                  print("_current_amount : $_amount");
                                                  if(transactionKey.currentState.validate()){
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

