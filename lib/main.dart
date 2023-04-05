import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Model Viewer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomepage(title: 'Model Viewer'),
    );
  }
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key, required this.title});

  final String title;

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  late String _filename;

  @override
  void initState() {
    _filename = 'https://modelviewer.dev/shared-assets/models/Astronaut.glb';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(_filename);
    return Scaffold(
      appBar: AppBar(title: Text("${widget.title}: $name")),
      body: Center(
        child: ModelViewer(
          key: Key(_filename),
          src: _filename,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
              // type: FileType.custom,
              // allowedExtensions: ['glb', 'gltf'],
              );
          debugPrint(result?.files.single.path);
          if (result?.files.single.path != null) {
            final path = result!.files.single.path!;
            setState(() {
              _filename = "file:///$path";
            });
          }
        },
        backgroundColor: Colors.indigoAccent,
        child: const Icon(Icons.folder_open),
      ),
    );
  }
}
