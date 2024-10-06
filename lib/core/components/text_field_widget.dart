import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.hintText,
    this.onChanged,
    this.controller,
  });

  final String? hintText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      cursorColor: const Color(0xff17192d),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: controller?.clear,
          icon: const Icon(Icons.clear),
          disabledColor: Colors.grey,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
