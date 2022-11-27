import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  final String text;

  const ButtonWidget({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minWidth: 250,
      color: primary,
      onPressed: onPressed,
      child: TextBold(text: text, fontSize: 18, color: Colors.white),
    );
  }
}
