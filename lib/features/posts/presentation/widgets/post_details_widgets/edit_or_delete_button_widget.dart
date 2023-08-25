import 'package:flutter/material.dart';

import '../../../../../core/app_theme/app_theme.dart';

class EditOrDeleteButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final bool isColorRedAccent;
  final IconData iconData;
  final String btnText;
  const EditOrDeleteButtonWidget({
    Key? key,
    required this.onPressed,
    required this.isColorRedAccent,
    required this.iconData,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isColorRedAccent ? Colors.redAccent : primaryColor,
        ),
      ),
      icon: Icon(iconData),
      label: Text(
        btnText,
      ),
    );
  }
}
