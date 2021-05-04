import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet/Services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _obscuretext = true;

  final _registernformkey = GlobalKey<FormState>();

  final _firstnamecontroller = TextEditingController();
  final _lastnamcontroller = TextEditingController();
  final _birthdaycontroller = TextEditingController();
  final _nicnumbercontroller = TextEditingController();
  final _contactnumbercontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  DateTime _currenttime;
  String _email;
  String _password;
  String _firstname;
  String _lastname;
  String _birthday;
  String _nic;
  String _contactnum;
  String _address;
  String _year;
  String _error = "";

  void _togglePass() {
    setState(() {
      _obscuretext = !_obscuretext;
    });
  }

  void clear() {
    setState(() {
      _firstnamecontroller.clear();
      _lastnamcontroller.clear();
      _birthdaycontroller.clear();
      _nicnumbercontroller.clear();
      _contactnumbercontroller.clear();
      _addresscontroller.clear();
      _emailcontroller.clear();
      _passwordcontroller.clear();
    });
  }

//Sow callender
  Future<Null> datepicker(BuildContext context) async {
    String month;
    String day;
    _currenttime = DateTime.now();
    final DateTime _picked = await showDatePicker(
        context: context,
        initialDate: DateTime(1990),
        firstDate: DateTime(1960),
        lastDate: _currenttime);
    if (_picked != null || _picked != _currenttime) {
      setState(() {
        _year = _picked.year.toString();
        month = _picked.month.toString();
        day = _picked.day.toString();
        _birthdaycontroller.text = day + "-" + month + "-" + _year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _registernformkey,
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //First name
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"))
                        ],
                        controller: _firstnamecontroller,
                        validator: (value1) {
                          if (value1 == null || value1.isEmpty) {
                            return 'Empty';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => _firstname = value,
                        decoration: InputDecoration(
                            labelText: "First name",
                            suffixIcon: Icon(Icons.person)),
                      ),
                      //Last name
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"))
                        ],
                        controller: _lastnamcontroller,
                        validator: (value1) {
                          if (value1 == null || value1.isEmpty) {
                            return 'Empty';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => _lastname = value,
                        decoration: InputDecoration(
                            labelText: "Last name",
                            suffixIcon: Icon(Icons.perm_identity)),
                      ),
                      //Birthday
                      TextFormField(
                        controller: _birthdaycontroller,
                        validator: (value) {
                          RegExp exp = RegExp(
                              r"^(0?[1-9]|[12][0-9]|3[01])\-(0?[1-9]|1[012])\-\d{4}$");

                          if (value == null || value.isEmpty) {
                            return 'Empty';
                          } else if (!exp.hasMatch(value)) {
                            return ' Wrong Value';
                          } else {
                            var arr = value.split('-');
                            if (_currenttime.year - 10 <= int.parse(arr[2])) {
                              return "Invalid Date";
                            } else {
                              return null;
                            }
                          }
                        },
                        onSaved: (value) => _birthday = value,

                        decoration: InputDecoration(
                          labelText: "Birthday",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.perm_contact_calendar),

                            onPressed: () => datepicker(context),
                            // color: Colors.black54,
                          ),
                        ),
                        //initialValue: _birthday,
                      ),
                      //NIC
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _nicnumbercontroller,
                        validator: (value1) {
                          if (value1 == null || value1.isEmpty) {
                            return 'Empty';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => _nic = value,
                        decoration: InputDecoration(
                            labelText: "NIC number",
                            suffixIcon: Icon(Icons.perm_contact_cal)),
                      ),
                      //Contact number
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _contactnumbercontroller,
                        validator: (value1) {
                          if (value1 == null || value1.isEmpty) {
                            return 'Empty';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => _contactnum = value,
                        decoration: InputDecoration(
                            labelText: "Contact number",
                            suffixIcon:
                                Icon(Icons.perm_contact_calendar_sharp)),
                      ),
                      //Address
                      TextFormField(
                        controller: _addresscontroller,
                        validator: (value1) {
                          RegExp exp = RegExp(
                              r"""[\^\`\~\!\@\#\$\%\&\*\(\)\_\-\+\=\{\}\[\]\|\:\;\“"’'\<\>\?\๐\฿]""");
                          if (value1 == null || value1.isEmpty) {
                            return 'Empty';
                          } else if (exp.hasMatch(value1)) {
                            return 'Invalid address';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => _address = value,
                        decoration: InputDecoration(
                            labelText: "Address", suffixIcon: Icon(Icons.home)),
                      ),
                      //email
                      TextFormField(
                        controller: _emailcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Empty';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Email not valid';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => _email = value,
                        decoration: InputDecoration(
                            labelText: "Email", suffixIcon: Icon(Icons.email)),
                      ),
                      //password
                      TextFormField(
                        controller: _passwordcontroller,
                        validator: (value1) {
                          if (value1 == null || value1.isEmpty) {
                            return 'Empty';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => _password = value,
                        decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: _obscuretext
                                ? Icon(Icons.remove_red_eye)
                                : Icon(Icons.remove_red_eye_outlined),
                            onPressed: _togglePass,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      //Submit Button
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _error,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                      onPressed: () async {
                                        _currenttime = DateTime.now();
                                        _registernformkey.currentState.save();
                                        if (_registernformkey.currentState
                                            .validate()) {
                                          try {
                                            print("register");
                                            UserCredential result = await _auth
                                                .createUserWithEmailAndPassword(
                                                    email: _email,
                                                    password: _password);

                                            print(
                                                "Register result: ${result.user.uid}");

                                            _users
                                                .doc(result.user.uid)
                                                .set({
                                                  'firstname': _firstname,
                                                  // John Doe
                                                  'lastname': _lastname,
                                                  // Stokes and Sons
                                                  'birthday': _birthday,
                                                  'nicnum': _nic,
                                                  'contactnum': _contactnum,
                                                  'address': _address,
                                                  'email': _email,
                                                  'password': _password,
                                                  // 42
                                                })
                                                .then((value) =>
                                                    print("User Added"))
                                                .catchError((error) {
                                                  print(
                                                      "Failed to add user: $error");
                                                  setState(() {
                                                    _error =
                                                        'Failed to add,try again!';
                                                  });
                                                });
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code == 'weak-password') {
                                              print(
                                                  'The password provided is too weak.');
                                              setState(() {
                                                _error =
                                                    'The password is too weak.';
                                              });
                                            } else if (e.code ==
                                                'email-already-in-use') {
                                              print(
                                                  'The account already exists for that email.');
                                              setState(() {
                                                _error =
                                                    'The account already exists';
                                              });
                                            }
                                          } catch (e) {
                                            print(e);
                                            setState(() {
                                              _error =
                                                  'Failed to add,try again!';
                                            });
                                          }
                                          //clear();
                                        }
                                      },
                                      child: Text("Submit")),
                                ),
                              ],
                            ),

                            SizedBox(),
                            //Login Button
                            Row(
                              children: [
                                Text("Already have an account?"),
                                Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        widget.toggleView();
                                        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
                                      },
                                      child: Text("LogIn")),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
