import 'package:chatting_application/Database_USer.dart';
import 'package:chatting_application/image_dp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic imageA = Icon(
    Icons.person,
    size: 100,
  );
  var _textController = TextEditingController();
  var _aboutController = TextEditingController();
  var _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot p = Provider.of<DocumentSnapshot>(context);
    print(p.toString() + 'abhi');
    if (p != null) {
      _textController.text = p.data()['name'];
      _aboutController.text = p.data()['about'];
      _phoneController.text = p.data()['phone'];
    }
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Center(
              child: InkWell(
                splashColor: Colors.black,
                borderRadius: BorderRadius.circular(70),
                onTap: () async {
                  var im = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageDp(img: imageA)));

                  if (im != null) {
                    setState(() {
                      imageA = Image.file(im);
                    });
                  }
                },
                child: Hero(
                  tag: 'image',
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(90)),
                    height: 150,
                    width: 150,
                    child: ClipOval(
                      child: imageA,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.blueAccent,
                ),
                title: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    suffixIcon: Icon(Icons.edit),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 15),
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  size: 35,
                  color: Colors.blueAccent,
                ),
                title: TextField(
                  maxLength: 40,
                  style: TextStyle(fontSize: 15),
                  controller: _aboutController,
                  decoration: InputDecoration(
                      labelText: 'About', suffixIcon: Icon(Icons.edit)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 15),
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  size: 35,
                  color: Colors.blueAccent,
                ),
                title: TextField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: 'Phone', suffixIcon: Icon(Icons.edit)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: MaterialButton(
                color: Colors.blueAccent,
                onPressed: () async {
                  print('update');
                  var user = await Users().updateDetails(_textController.text,
                      _aboutController.text, _phoneController.text);
                  print(user);
                  Toast.show('Updated', context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
