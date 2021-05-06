import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  var user;
  UserProfile(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserProfile'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/user.png'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name',
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 25)),
                    Text(user['name'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 20,
                            color: Colors.grey)),
                    SizedBox(
                      height: 30,
                    ),
                    Text('About',
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 25)),
                    Text(user['about'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 20,
                            color: Colors.grey)),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Phone',
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 25)),
                    Text(user['phone'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 20,
                            color: Colors.grey)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
