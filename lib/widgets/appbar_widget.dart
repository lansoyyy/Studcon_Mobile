import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget AppbarWidget(
  String title,
) {
  return AppBar(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: primary,
    title: TextRegular(text: title, fontSize: 18, color: Colors.white),
    centerTitle: true,
  );
}
