
import 'package:random_color/random_color.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  User u;
  Users({this.u});

  CollectionReference firestore =
      FirebaseFirestore.instance.collection('users');

  addUserDetails() async {
    print('abhinai');
    try {
      return await firestore.doc(u.uid).set({
        'name': u.email.split('@')[0],
        'about': 'Hey There,I am using ChatTalk',
        'phone': '',
        'color': RandomColor()
            .randomColor(colorSaturation: ColorSaturation.highSaturation)
            .value
      });
    } catch (e) {
      print('raale');
      return null;
    }
  }

  Stream<DocumentSnapshot> get getUserDetails {
    return firestore.doc(FirebaseAuth.instance.currentUser.uid).snapshots();
  }

  Future updateDetails(String name, String avout, String phone) async {
    try {
      await firestore
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'name': name, 'about': avout, 'phone': phone}).then(
              (value) => print('updatedada'));
      await messages
          .where('id', isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  element.reference.update({
                    'reference': name,
                  });
                })
              });
    } catch (e) {
      print(e);
    }
  }

  Future getUserName() async {
    var a;
    try {
      a = await firestore
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) => value.data()['name']);
    } catch (e) {
      print('hawa');
    }
    return a;
  }

  Future getColor() async {
    var a;
    try {
      a = await firestore
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) => value.data()['color']);
    } catch (e) {
      print('hawa');
    }
    return a;
  }

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  uploadMsg(String message) async {
    if (message == '') {
      return;
    }
    try {
      await messages.add({
        'id': u.uid,
        'message': message,
        'created': DateTime.now(),
        'reference': await getUserName(),
        'color': await getColor(),
      });
    } catch (e) {
      print('orey hawle');
    }
  }

  Stream<QuerySnapshot> getMsgs() {
    return messages.orderBy('created').snapshots();
    /*.then((QuerySnapshot value) {
      value.docs.forEach((element) {
        print(element.data()['message']);
      });
    });*/
  }

  Stream<QuerySnapshot> getAlltheUsers() {
    return firestore.snapshots();
  }
}
