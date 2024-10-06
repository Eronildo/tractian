import 'package:flutter/material.dart';
import 'package:simple_ref/simple_ref.dart';
import 'package:tractian/ui/home_page.dart';
import 'package:tractian/core/themes/app_theme.dart';

void main() {
  runApp(const RefScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const HomePage(),
    );
  }
}
