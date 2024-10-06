import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.filled,
    this.onPressed,
    required this.text,
    required this.iconData,
    this.height,
    this.width,
    this.contentPadding = 12,
  });

  const ButtonWidget.large({
    super.key,
    required this.filled,
    this.onPressed,
    required this.text,
    required this.iconData,
    this.height = 80.0,
    this.width = double.maxFinite,
    this.contentPadding = 20,
  });

  final bool filled;
  final void Function()? onPressed;
  final String text;
  final IconData iconData;
  final double? height;
  final double? width;
  final double contentPadding;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      stepWidth: width,
      stepHeight: height,
      child: OutlinedButton(
        onPressed: onPressed,
        iconAlignment: IconAlignment.start,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: contentPadding),
          iconColor: Color(
            filled ? 0xffffffff : 0xFF77818C,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          backgroundColor:
              filled ? const Color(0xff2188ff) : Colors.transparent,
          side: BorderSide(
            width: 2,
            color: Color(
              filled ? 0xff2188ff : 0xFFD8DFE6,
            ),
          ),
          foregroundBuilder: (_, __, ___) => Row(
            children: [
              Icon(iconData),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Color(
                      filled ? 0xffffffff : 0xFF77818C,
                    ),
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        child: const SizedBox.shrink(),
      ),
    );
  }
}
