import 'package:flutter/material.dart';
import 'package:test_assignment_nasa/data/models/APODModel.dart';
import 'package:test_assignment_nasa/services/nasa_service.dart';
import 'package:test_assignment_nasa/presentation/image_page.dart';
import 'package:test_assignment_nasa/services/toast_service.dart';

class APODPreviewPage extends StatefulWidget {
  const APODPreviewPage({super.key});

  @override
  createState() => _APODPreviewPageState();
}

class _APODPreviewPageState extends State<APODPreviewPage> {
  final NasaService _nasaService = NasaService();
  final GlobalKey _imageKey = GlobalKey();
  double _imageWidth = 0;
  Future<APODModel>? _apodData;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchAPOD();
  }

  void _fetchAPOD() {
    // TODO: let user choose the date
    final yesterday = NasaDate.fromDateTime(
      DateTime.now().subtract(const Duration(days: 1)),
    );

    _apodData = _nasaService
        .fetchAPOD(
      /// Enable for testing as needed,
      /// TODO: use --dart-define=TEST_DATE=2022-01-01 to set the date
      // date: yesterday,
    )
        .catchError((e) {
      // TODO: make user friendly message
      ToastService().error(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NASA APOD')),
      body: FutureBuilder<APODModel>(
        future: _apodData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          _imageUrl = snapshot.data?.url;

          if (_imageUrl == null) {
            return Center(child: Text("No image URL provided"));
          }
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (_imageUrl == null) {
                        return;
                      }
                      Navigator.of(context).pushNamed(
                        '/image',
                        arguments: ImagePageArgs(imageUrl: _imageUrl!),
                      );
                    },
                    child: Image.network(
                      _imageUrl!,
                      key: _imageKey,
                      height: MediaQuery.of(context).size.height / 2,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // TODO: check for you
                        return Text('Image not available');
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          _setScaledImageWidth();
                          return child;
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Container(
                    width: _imageWidth == 0
                        ? MediaQuery.of(context).size.width / 2
                        : _imageWidth,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snapshot.data?.title ?? 'No Title Available',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.data?.explanation ??
                        'No Description Available'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _setScaledImageWidth() {
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
