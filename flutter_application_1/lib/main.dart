import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/wrappper.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/user_acc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User_acc?>.value(
      value: AuthService().user,
      catchError: (_, __) {},
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
