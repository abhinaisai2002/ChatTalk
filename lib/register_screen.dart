
import 'package:chatting_application/auth.dart';
import 'package:chatting_application/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  String _email = '';
  String _password = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String validateEmail(String s) {
    RegExp r = new RegExp('[a-z0-9]+@[a-z.]+');
    if (r.hasMatch(s))
      return null;
    else {
      return 'Enter a valid email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/back_ground.png'))),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Container(
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
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onSaved: (value) => _email = value,
                          validator: (value) => validateEmail(value),
                          controller: _emailController,
                          style: TextStyle(fontSize: 16),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.blueGrey,
                              ),
                              hintText: 'Email',
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
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
                        TextFormField(
                          validator: (value) => value.length < 6
                              ? 'Enter must be 8 charactes'
                              : null,
                          onSaved: (value) => _password = value,
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
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
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
                        TextFormField(
                          validator: (value) =>
                              value != _passwordController.text
                                  ? 'Enter the same password'
                                  : null,
                          obscureText: true,
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
                              hintText: 'Re-enter password',
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
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
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        dynamic _user =
                            await Authentication().register(_email, _password);
                        if (_user.runtimeType == User) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Verify the email sent to you')));
                        } else if (_user.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email already in use')));
                        }
                      }
                    },
                    child: Text('Register'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Already have an account ?  ',
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 17),
                      ),
                      InkWell(
                        splashColor: Colors.deepPurple,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: Text('Log in',
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 17,
                                color: Colors.deepPurple)),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
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
      ),
    );
  }
}
