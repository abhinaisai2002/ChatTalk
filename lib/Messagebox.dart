import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBox extends StatelessWidget {
  Map m, n;
  MessageBox(Map a, [Map b = const {'id': 'a'}]) {
    this.m = a;
    this.n = b;
  }
  @override
  Widget build(BuildContext context) {
    var f = new DateFormat('yyyy-MM-dd hh:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(
        m['created'].microsecondsSinceEpoch);
    var da = f.format(date);
    /* var time = date.hour.toString() + ':' + date.minute.toString();
    print(time);*/
    Color c = Color(m['color']);
    if (m['id'] == FirebaseAuth.instance.currentUser.uid) {
      return Padding(
          padding: EdgeInsets.all(5),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: c),
                  constraints: BoxConstraints(maxWidth: 225),
                  child: Text(
                    m['message'],
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 15),
                  ),
                ),
                Text(
                  da,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]),
            ],
          ));
    } else if (m['id'] == n['id']) {
      return Padding(
          padding: EdgeInsets.all(2),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        /*boxShadow: [
                          BoxShadow(
                              blurRadius: 20,
                              color: Colors.black54,
                              offset: Offset(10, 10))
                        ],*/
                        borderRadius: BorderRadius.circular(20),
                        color: c),
                    constraints: BoxConstraints(maxWidth: 225, minWidth: 50),
                    child: Text(
                      m['message'],
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 15),
                    )),
                Text(
                  da,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ])
            ],
          ));
    } else {
      return Padding(
          padding: EdgeInsets.all(2),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(m['reference'],
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      //decoration: TextDecoration.underline
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        /* boxShadow: [
                          BoxShadow(
                              blurRadius: 20,
                              color: Colors.black54,
                              offset: Offset(10, 10))
                        ],*/
                        borderRadius: BorderRadius.circular(20),
                        color: c),
                    constraints: BoxConstraints(maxWidth: 225, minWidth: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m['message'],
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )),
                Text(
                  da,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ])
            ],
          ));
    }
  }
}
