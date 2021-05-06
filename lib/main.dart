import 'package:chatting_application/auth.dart';
import 'package:chatting_application/what_to_use.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider.value(
            value: Authentication().user,
            initialData: null,
            child: MaterialApp(
              home: Showing(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Container(
            color: Colors.blue,
            child: SpinKitRing(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
/*
from github
*/
