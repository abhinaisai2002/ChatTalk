import 'package:chatting_application/Database_USer.dart';
import 'package:chatting_application/auth.dart';
import 'package:chatting_application/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: Users().getUserDetails,
      initialData: null,
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('Settings'), actions: [
          IconButton(
            tooltip: 'Sign Out',
            splashColor: Colors.deepPurpleAccent,
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Authentication().signOut();
              await Authentication().googleSignOut();
              Navigator.pop(context);
            },
            padding: EdgeInsets.only(left: 10, right: 15),
          ),
        ]),
        body: Profile(),
      ),
    );
  }
}
