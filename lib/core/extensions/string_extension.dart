import 'package:flutter/material.dart';

extension StringExtension on String {
  List<String> splitWith({required String text}) {
    final RegExp regExp = RegExp(text, caseSensitive: false);
    final List<String> result = [];

    // Find all parts
    int lastMatchEnd = 0;
    for (final match in regExp.allMatches(this)) {
      // Add part of the text before the match part
      if (match.start > lastMatchEnd) {
        result.add(substring(lastMatchEnd, match.start));
      }
      // Add match part
      result.add(match.group(0)!);
      lastMatchEnd = match.end;
    }

    // Add end part of the text
    if (lastMatchEnd < length) {
      result.add(substring(lastMatchEnd));
    }

    return result;
  }

  List<TextSpan> getTextSpansWithHighlightedTexts(
    String searchQuery,
    TextStyle style,
  ) {
    List<String> parts = splitWith(text: searchQuery);

    return parts.map((part) {
      if (part.toLowerCase() == searchQuery.toLowerCase()) {
        return TextSpan(
          text: part,
          style: style.copyWith(color: Colors.red),
        );
      } else {
        return TextSpan(
          text: part,
          style: style,
        );
      }
    }).toList();
  }
}
