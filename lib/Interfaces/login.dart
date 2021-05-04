import 'package:e_wallet/Services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function toggleView;

  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _loginformkey = GlobalKey<FormState>();

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  bool _obscuretext = true;
  String _email;
  String _password;
  String _error = "";

  void _togglePass() {
    setState(() {
      _obscuretext = !_obscuretext;
    });
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
              key: _loginformkey,
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
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
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: _togglePass,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _error,
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    _loginformkey.currentState.save();
                                    if (_loginformkey.currentState
                                        .validate()) {}
                                  },
                                  child: Text("Forgot Password")),
                            ),
                            Expanded(
                              child: TextButton(
                                  onPressed: () async {
                                    _loginformkey.currentState.save();
                                    if (_loginformkey.currentState.validate()) {
                                      print("logging in");
                                      try {
                                        UserCredential result = await _auth
                                            .signInWithEmailAndPassword(
                                                email: _email,
                                                password: _password);
                                        print(
                                            "loged in sucessfully, user : ${result.user.uid}");
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          print("user-not-found");
                                          setState(() {
                                            _error = 'user not found';
                                          });
                                        } else if (e.code == 'wrong-password') {
                                          print("wrong-password");
                                          setState(() {
                                            _error = 'wrong password';
                                          });
                                        }
                                      }
                                    }
                                  },
                                  child: Text("LogIn")),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Haven't created an account yet?"),
                            Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    widget.toggleView();
                                    //Navigator.of(context).pushNamed(AppRoutes.);
                                    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Register()));
                                  },
                                  child: Text("Register")),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
