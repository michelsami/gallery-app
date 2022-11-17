import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? imageFile;

  Future pickImageFromGallery(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // final imagePath = File(image.path);
      final imagePathToSave = await saveImagePath(image.path);
      setState(() => imageFile = imagePathToSave);
    } on PlatformException catch (e) {
      print("failed to pick image : $e");
    }
  }

  Future<File> saveImagePath(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("log out"),
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  elevation: 0,
                  content: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          pickImageFromGallery(ImageSource.gallery);
                        },
                        icon: Image.asset(
                          "icons/gallery.png",
                          height: MediaQuery.of(context).size.width * 0.1,
                        ),
                        label: Text("Gallery"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          pickImageFromGallery(ImageSource.camera);
                        },
                        icon: Image.asset(
                          "icons/camera.png",
                          height: MediaQuery.of(context).size.width * 0.1,
                        ),
                        label: Text("Camera"),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Text("upload"),
          ),
        ],
      ),
    );
  }
}
