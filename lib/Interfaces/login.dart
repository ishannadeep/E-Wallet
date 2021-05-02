import 'package:e_wallet/Interfaces/register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscuretext = true;
  final _loginformkey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  String _email;
  String _password;

  void _togglePass() {
    setState(() {
      _obscuretext = !_obscuretext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LogIn"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 17,
                child: Form(
                  key: _loginformkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailcontroller,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => _email = value,
                        decoration: InputDecoration(
                            labelText: "Email",
                            suffixIcon: Icon(Icons.email_outlined)),
                      ),
                      TextFormField(
                        controller: _passwordcontroller,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => _password = value,
                        obscureText: _obscuretext,
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
                      Row(
                        children: [
                          Expanded(flex: 2, child: SizedBox()),
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: TextButton(
                                            onPressed: () {
                                              _loginformkey.currentState.save();
                                              if (_loginformkey.currentState.validate())
                                              {

                                              }
                                            },
                                            child: Text("LogIn"))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                          onPressed: () {
                                            _loginformkey.currentState.save();
                                            if (_loginformkey.currentState.validate())
                                            {

                                            }
                                          },
                                          child: Text("Forgot Password")),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: TextButton(
                                            onPressed: ()
                                            {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => Register()),
                                              );

                                            },
                                            child: Text("Register"))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(flex: 2, child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
