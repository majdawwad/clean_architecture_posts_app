import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.multiLines,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "You must to fill the $name's field";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: name,
        ),
        maxLines: multiLines ? 6 : 1,
        minLines: multiLines ? 6 : 1,
      ),
    );
  }
}
