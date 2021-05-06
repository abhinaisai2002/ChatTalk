import 'dart:async';

import 'package:chatting_application/Database_USer.dart';
import 'package:chatting_application/Messagebox.dart';
import 'package:flutter/material.dart';

class AllMessages extends StatefulWidget {
  AllMessages() {}
  @override
  _AllMessagesState createState() => _AllMessagesState();
}

class _AllMessagesState extends State<AllMessages> {
  var scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Users().getMsgs(),
        builder: (context, snapshot) {
          Timer(
            Duration(seconds: 1),
            () => scroll.jumpTo(scroll.position.maxScrollExtent),
          );
          if (snapshot.hasData) {
            var s = snapshot.data.docs;
            return ListView.builder(
                controller: scroll,
                itemCount: s.length,
                itemBuilder: (context, index) {
                  if (index == 0)
                    return MessageBox(s[index].data());
                  else
                    return MessageBox(s[index].data(), s[index - 1].data());
                });
          }
          return Container(
          );
        });
  }
}
