import 'package:client/features/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui' as ui;




void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      // This is non-web specific code
      // You can reference any code that needs 'dart:ui' here
    }
    return const MaterialApp(
      theme: ,
      home: OnboardingPage(),
    );
  }
}
