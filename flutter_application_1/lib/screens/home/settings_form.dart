import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_acc.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName = '';
  String _currentSugars = '';
  int _currentStrength = 100;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User_acc>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(children: [
                Text('Update your brew settings',
                    style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return "Please enter a name";
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() => _currentName = value)),
                SizedBox(
                  height: 20,
                ),
                //dropdown
                DropdownButtonFormField<String>(
                    decoration: textInputDecoration,
                    value: userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _currentSugars = value!)),
                Slider(
                  value: (_currentStrength).toDouble(),
                  activeColor: Colors.brown[_currentStrength],
                  inactiveColor: Colors.brown[_currentStrength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currentStrength = val.round()),
                ),
                //slider
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400],
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  child: Text('Update'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                          this._currentSugars,
                          this._currentName,
                          _currentStrength);
                      Navigator.pop(context);
                    }
                  },
                )
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
