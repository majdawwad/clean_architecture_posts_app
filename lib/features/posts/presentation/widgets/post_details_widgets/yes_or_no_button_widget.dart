import 'package:flutter/material.dart';

class YesOrNoButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String btnText;
  const YesOrNoButtonWidget({
    Key? key,
    required this.onPressed,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        btnText,
        style: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
