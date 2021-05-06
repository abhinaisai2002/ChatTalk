import 'package:chatting_application/auth.dart';
import 'package:chatting_application/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificatiob extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool verified = FirebaseAuth.instance.currentUser.emailVerified;
    if (verified == false) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.lightBlue,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Please verify the mail sent to you',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'OpenSans,', fontSize: 20),
            ),
            MaterialButton(
              onPressed: () async {
                await Authentication().signOut();
                await Authentication().googleSignOut();
              },
              child: Text(
                'Please sign out',
                style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
              ),
              color: Colors.deepPurple,
            )
          ]),
        ),
      );
    } else {
      return Home();
    }
  }
}
