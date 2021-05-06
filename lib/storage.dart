/*import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  Future uploadImage(String uid) async {
    print('uploading');
    await FirebaseStorage.instance.ref().child(uid).putString(
        'https://www.global.hokudai.ac.jp/wp-content/uploads/2020/07/default-avatar-profile-image-vector-social-media-user-icon-potrait-182347582.jpg');
  }

  Future<String> getImage(String uid) async {
    try {
      String a =
          await FirebaseStorage.instance.ref().child(uid).getDownloadURL();
      return a;
    } catch (e) {
      print('fsdfbshgfsfbdhghsdgfhj');
    }
  }
}
*/