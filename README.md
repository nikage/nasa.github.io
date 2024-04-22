# Flutter Web app to display NASA’s Astronomy Picture of the Day

Test assignment 

## See live page 

https://nikage.github.io/nasa-beta.github.io

## Development

- Use `--dart-define=APOD_TEST_DATE=YYYY-MM-DD` to test with a specific date
  - EXAMPLE: `$ flutter run --dart-define=APOD_TEST_DATE=2021-08-01`
    
## Deployment

1. `git clone git@github.com:nikage/nasa-beta.github.io.git`
2. `flutter build web --release`
3. `git push origin main`