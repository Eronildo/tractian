import 'package:flutter/material.dart';
import 'package:tractian/core/constants/app_constants.dart';
import 'package:tractian/ui/widgets/home_buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(image: AssetImage(AppConstants.imageLogoPath)),
      ),
      body: const HomeButtons(),
    );
  }
}
