import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageDp extends StatefulWidget {
  var img;

  ImageDp({this.img});
  @override
  _ImageDpState createState() => _ImageDpState();
}

class _ImageDpState extends State<ImageDp> {
  File image;
  setImageDp() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blue,
          toolbarTitle: 'Edit',
        ),
      );
    }
    setState(() {});
  }

  imageSelector() {
    if (image == null) {
      return Center(
        child: Container(
            height: 360,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: widget.img),
      );
    } else {
      setState(() {});
      return Center(
        child: Container(
          height: 350,
          width: 600,
          child: Image.file(image),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'image',
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, image);
            },
          ),
          backgroundColor: Colors.black,
          actions: [
            TextButton(
                onPressed: () {
                  setImageDp();
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                )),
          ],
        ),
        /*image ??
              Center(
                child: Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                ),
              ),*/
        body: imageSelector(),
      ),
    );
  }
}
