import 'package:chatting_application/Database_USer.dart';
import 'package:chatting_application/UserProfile.dart';
import 'package:flutter/material.dart';

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Users().getAlltheUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var s = snapshot.data.docs;
              return ListView.builder(
                  itemCount: s.length,
                  itemBuilder: (context, index) {
                    var data = s[index].data();
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfile(data)));
                      },
                      contentPadding: EdgeInsets.all(10),
                      leading: Icon(
                        Icons.person,
                        size: 40,
                        color: Color(data['color']),
                      ),
                      title: Text(
                        data['name'],
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 25),
                      ),
                      subtitle: Text(
                        data['about'],
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 15),
                      ),
                    );
                  });
            }
            return Center(
              child: Text('Loading'),
            );
          },
        ),
      ),
    );
  }
}
