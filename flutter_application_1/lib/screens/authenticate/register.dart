import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  //text feild state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('sign up to to Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Sign in'),
            style: TextButton.styleFrom(primary: Colors.black),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return "Email can't be empty";
                    }
                    return null;
                  },
                  onChanged: ((value) {
                    setState(() {
                      email = value;
                    });
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value != null && value.length < 6) {
                      return "Enter a password 6+ chars";
                    }
                    return null;
                  },
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'pleasse supply a valid email';
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pink[400],
                        textStyle: const TextStyle(color: Colors.white))),
                SizedBox(
                  height: 12,
                ),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14)),
              ],
            )),
      ),
    );
  }
}
