import 'package:chatting_application/Database_USer.dart';
import 'package:chatting_application/allusers.dart';
import 'package:chatting_application/messagers.dart';
import 'package:chatting_application/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to ChatTalk'),
        actions: [
          IconButton(
              iconSize: 25,
              color: Colors.white,
              icon: Icon(Icons.people),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllUsers()));
              }),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: AllMessages(),
          )),
          Container(
            child: TextField(
              keyboardType: TextInputType.text,
              maxLines: null,
              controller: _textController,
              style: TextStyle(fontSize: 16),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    color: Colors.blue,
                    onPressed: () {
                      Users(u: FirebaseAuth.instance.currentUser).uploadMsg(
                        _textController.text,
                      );
                      _textController.text = '';
                    },
                  ),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.blueGrey,
                  ),
                  hintText: 'Type a message',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  ))),
            ),
          ),
        ],
      ),
    );
  }
}
