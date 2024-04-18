import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final ImagePageArgs args;

  ImagePage({required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Full Screen Image')),
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Center(
          child: Image.network(args.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class ImagePageArgs {
  final String imageUrl;

  ImagePageArgs({required this.imageUrl});
}
