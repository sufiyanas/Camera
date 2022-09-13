import 'dart:io';

import 'package:camera/model/image_model.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

class GallerScreen extends StatefulWidget {
  const GallerScreen({Key? key}) : super(key: key);

  @override
  State<GallerScreen> createState() => _GallerScreenState();
}

class _GallerScreenState extends State<GallerScreen> {
  Box<ImageModel>? imageBox;
  @override
  void initState() {
    imageBox = Hive.box<ImageModel>('ImageDB');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery View'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ValueListenableBuilder(
          valueListenable: imageBox!.listenable(),
          builder:
              (BuildContext context, Box<ImageModel> images, Widget? child) {
            return GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 0, mainAxisSpacing: 20),
              itemBuilder: (context, index) {
                final key = images.keys.toList()[index];
                final image = images.get(key);
                return Image(image: FileImage(File(image!.image)));
              },
            );
          },
        ),
      ),
    );
  }
}
