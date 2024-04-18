import 'package:flutter/material.dart';
import 'package:test_assignment_nasa/presentation/apod_preview_page.dart';
import 'package:test_assignment_nasa/presentation/image_page.dart';

import 'presentation/not_found_page.dart';  // Assuming you meant ImagePage by this.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => APODPreviewPage());
          case '/image':
            if (settings.arguments is ImagePageArgs) {
              final ImagePageArgs args = settings.arguments as ImagePageArgs;
              return _createFadeRoute(page: ImagePage(args: args), settings: settings);
            }
            break;
          default:
            return _createFadeRoute(page: NotFoundPage(), settings: settings);  // Apply fade transition to NotFoundPage as well
        }
        // Default route if nothing else matches
        return _createFadeRoute(page: NotFoundPage(), settings: settings);
      },
    );
  }

  Route<dynamic> _createFadeRoute({required Widget page, RouteSettings? settings}) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 350),
    );
  }
}
