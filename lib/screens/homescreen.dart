import 'dart:io';
import 'package:camera/model/image_model.dart';
import 'package:camera/screens/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    imageBox = Hive.box<ImageModel>('ImageDB');
    super.initState();
  }

  String? imagePath;
  Box<ImageModel>? imageBox;

  Future<void> pickImageCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      this.imagePath = pickedImage.path;
    });
  }

  Future<void> addImageToDB() async {
    if (imagePath == null) {
      print('Something error');
      return;
    }
    final image = ImageModel(image: imagePath!);
    await imageBox!.add(image);
    print('Image added to the database');
    setState(() {
      imagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Camera '),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GallerScreen()));
            },
            icon: Icon(Icons.image),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 300,
              height: 300,
              child: Image(
                image: (imagePath == null)
                    ? AssetImage('assets/images/iStock-476085198.jpg')
                    : FileImage(File(imagePath!)) as ImageProvider,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      pickImageCamera();
                    },
                    child: const Text('Camera')),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      addImageToDB();
                    },
                    child: const Text('Save')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
