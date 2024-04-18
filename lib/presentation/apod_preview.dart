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
            var imgUrl = snapshot.data?['hdurl'];
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(snapshot.data?['title'] ?? 'No Title Available'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      imgUrl ,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: $error. StackTrace: $stackTrace');
                        return Text('Image not available');
                      },
                    ),
                  ),
                  Text(snapshot.data?['explanation'] ??
                      'No Description Available'),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
