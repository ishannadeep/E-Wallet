import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscuretext = true;

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
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Name", suffixIcon: Icon(Icons.person)),
                    ),
                    TextFormField(
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
                        SizedBox(width: 50,),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: TextButton(onPressed: () {}, child: Text("LogIn"))),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {}, child: Text("Forgot Password")),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: TextButton(onPressed: () {}, child: Text("Register"))),
                                ],
                              ),

                            ],
                          ),
                        ),
                        SizedBox(width: 50,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
