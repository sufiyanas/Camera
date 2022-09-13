import 'package:camera/model/image_model.dart';
import 'package:camera/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ImageModelAdapter());
  }

  await Hive.openBox<ImageModel>('ImageDb');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Camera App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
