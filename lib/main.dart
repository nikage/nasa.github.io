import 'package:flutter/material.dart';
import 'package:test_assignment_nasa/presentation/apod_preview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: APODPreview(),
    );
  }
}

