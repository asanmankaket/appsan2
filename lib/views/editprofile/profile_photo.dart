import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../configs/api.dart';

class ProfilePhoto extends StatefulWidget {
  ProfilePhoto({Key? key, required this.dataavatar}) : super(key: key);
  String dataavatar;
  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  File? _image;
  bool isTapped = false;
  Future getImage(ImageSource wayimage) async {
    final image = await ImagePicker().pickImage(source: wayimage);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this._image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 134, 156),
        actions: [
          _image != null
              ? TextButton(
                  onPressed: () {
                    if (!isTapped) {
                      isTapped = true;
                      sendDataProfile3(_image!, context);
                    }
                  },
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                  ))
              : Text(''),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            _image != null
                ? ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(80), // Image radius
                      child: Image.file(_image!, fit: BoxFit.cover),
                    ),
                  )
                : CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(widget.dataavatar),
                  ),
            TextButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: Text('ถ่ายรูป')),
            TextButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Text('อัปโหลดรูปภาพ'))
          ],
        ),
      ),
    );
  }
}
