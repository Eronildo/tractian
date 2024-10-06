import 'package:flutter/material.dart';

class StateWidget extends StatelessWidget {
  const StateWidget({
    super.key,
    required this.text,
    required this.iconData,
    required this.iconColor,
  });

  const StateWidget.error({
    super.key,
    required this.text,
    this.iconData = Icons.warning_amber_rounded,
    this.iconColor = const Color.fromARGB(255, 197, 179, 12),
  });

  const StateWidget.empty({
    super.key,
    required this.text,
    this.iconData = Icons.manage_search,
    this.iconColor = const Color(0xff2188ff),
  });

  final String text;
  final IconData iconData;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 40,
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
