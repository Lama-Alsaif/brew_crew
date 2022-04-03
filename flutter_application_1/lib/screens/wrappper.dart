import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/authenticate/authenticate.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/user_acc.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User_acc?>(context);
    //return either Home or Authenticate widget

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
