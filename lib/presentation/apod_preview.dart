import 'package:flutter/material.dart';
import 'package:test_assignment_nasa/nasa_service.dart';

class APODPreview extends StatefulWidget {
  const APODPreview({super.key});

  @override
  createState() => _APODPreviewState();
}

class _APODPreviewState extends State<APODPreview> {
  final NasaService _nasaService = NasaService();

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
                    children: <Widget>[
                      Text(
                        snapshot.data?['title'] ?? 'No Title Available',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Image.network(
                        imgUrl,
                        height: MediaQuery.of(context).size.height / 2,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error. StackTrace: $stackTrace');
                          return Text('Image not available');
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data?['explanation'] ??
                            'No Description Available'),
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
}
