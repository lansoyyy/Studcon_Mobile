import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget AppbarWidget(
  String title,
) {
  return AppBar(
    elevation: 0,
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    title: TextRegular(text: title, fontSize: 18, color: Colors.black),
    centerTitle: true,
  );
}
