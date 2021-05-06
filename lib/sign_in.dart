import 'package:chatting_application/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SignIn extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/back_ground.png'))),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/user.png'),
                    radius: MediaQuery.of(context).size.height / 12,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _emailController,
                        style: TextStyle(fontSize: 16),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.blueGrey,
                            ),
                            hintText: 'Email',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: true,
                        controller: _passwordController,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'OpenSans',
                        ),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.blueGrey,
                            ),
                            hintText: 'Password',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(18, 97, 255, 10),
                      textStyle:
                          TextStyle(fontFamily: 'OpenSans', fontSize: 16)),
                  onPressed: () async {
                    dynamic user = await Authentication().singIn(
                        _emailController.text, _passwordController.text);
                    if (user.runtimeType == User) {
                      Navigator.pop(context);
                    } else if (user.code == 'user-not-found') {
                      Toast.show('Invalid Email', context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    } else if (user.code == 'wrong-password') {
                      Toast.show('Check yout password', context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    } else if (user.code == 'unknown') {
                      Toast.show('Enter details', context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    } else {
                      Toast.show('Email doesnt exist', context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    }
                  },
                  child: Text('Sign In'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 40, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () async {
                      User googleUser = await Authentication().googleSign();
                      if (googleUser.runtimeType == User) {
                        Navigator.pop(context);
                      }
                    },
                    splashColor: Colors.lightBlueAccent,
                    child: ListTile(
                      leading: Image.asset(
                        'assets/search.png',
                        height: 30,
                      ),
                      title: Text(
                        'Sign in with Google',
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.bottomCenter,
                child: Text(
                  'From ChatTalk',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 30,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
