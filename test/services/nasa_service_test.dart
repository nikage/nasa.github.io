import 'package:flutter_test/flutter_test.dart';
import 'package:test_assignment_nasa/data/models/APODModel.dart';
import 'package:test_assignment_nasa/services/nasa_service.dart';

void main() {
  late NasaService nasaService;

  setUp(() {
    nasaService = NasaService();
  });

  test('fetchAPOD', () async {
    APODModel apod = await nasaService.fetchAPOD();
    expect(apod.title, isNotNull);
    expect(apod.url, isNotNull);
    expect(apod.explanation, isNotNull);
  });

  test('fetchAPOD with date', () async {
    APODModel apod = await nasaService.fetchAPOD(
      date: NasaDate.fromDateTime(DateTime(2021, 10, 10)),
    );
    expect(apod.title, isNotNull);
    expect(apod.url, isNotNull);
    expect(apod.explanation, isNotNull);
  });

  test('fetchAPODRandom', () async {
    APODModels res = await nasaService.fetchAPODRandom(count: 5);
    expect(res.length, 5);
    res.forEach((apod) {
      expect(apod.title, isNotNull);
      expect(apod.url, isNotNull);
      expect(apod.explanation, isNotNull);
    });
  });
}
