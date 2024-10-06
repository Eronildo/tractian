import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
            color: Color(0xFFEAEEF2),
            height: 0,
            thickness: 2,
          );
  }
}
