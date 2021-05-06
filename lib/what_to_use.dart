import 'package:chatting_application/after_verify.dart';
import 'package:chatting_application/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Showing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      return Register();
    } else {
      return EmailVerificatiob();
    }
  }
}
