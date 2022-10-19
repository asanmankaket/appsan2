import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../configs/api.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({Key? key, required this.dataavatar}) : super(key: key);
  final String dataavatar;
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
        backgroundColor: const Color.fromARGB(255, 76, 124, 172),
        actions: [
          _image != null
              ? TextButton(
                  onPressed: () {
                    if (!isTapped) {
                      isTapped = true;
                      sendDataProfile3(_image!, context);
                    }
                  },
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                  ))
              : const Text(''),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _image != null
                ? ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(120), // Image radius
                      child: Image.file(_image!, fit: BoxFit.cover),
                    ),
                  )
                : CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(widget.dataavatar),
                  ),
            const SizedBox(height: 60),
            SizedBox(
              width: 330,
              height: 80,
              child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(70, 15, 70, 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: const Color.fromARGB(255, 156, 156, 156),
                    primary: const Color.fromARGB(255, 255, 255, 255),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.camera),
                      const SizedBox(width: 20),
                      const Text('ถ่ายรูป'),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 330,
              height: 80,
              child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(70, 15, 70, 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: const Color.fromARGB(255, 96, 192, 224),
                    primary: const Color.fromARGB(255, 255, 255, 255),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.photo_album),
                      const SizedBox(width: 20),
                      const Text('อัปโหลดรูปภาพ'),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
