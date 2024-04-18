import 'package:flutter/material.dart';
import 'package:test_assignment_nasa/nasa_service.dart';

class APODPreview extends StatefulWidget {
  const APODPreview({super.key});

  @override
  createState() => _APODPreviewState();
}

class _APODPreviewState extends State<APODPreview> {
  final NasaService _nasaService = NasaService();
  final GlobalKey _imageKey = GlobalKey();
  double _imageWidth = 0;

  Future<Map<String, dynamic>>? _apodData;

  @override
  void initState() {
    super.initState();
    _apodData = _nasaService.fetchAPOD();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NASA APOD')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _apodData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            var imgUrl = snapshot.data?['url'];
            if (imgUrl != null) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        imgUrl,
                        key: _imageKey,
                        height: MediaQuery.of(context).size.height / 2,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Text('Image not available');
                        },
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            setScaledImageWidth();
                            return child;
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                      Container(
                        width: _imageWidth == 0 ? MediaQuery.of(context).size.width / 2 : _imageWidth,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data?['title'] ??
                              'No Title Available',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data?['explanation'] ?? 'No Description Available'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text("No image URL provided"));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void setScaledImageWidth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? box = _imageKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null && _imageWidth != box.size.width) {
        setState(() {
          _imageWidth = box.size.width;
        });
      }
    });
  }
}
