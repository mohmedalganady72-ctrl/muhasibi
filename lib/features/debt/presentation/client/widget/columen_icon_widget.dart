import 'package:ccount/core/shared/container_icon.dart';
import 'package:ccount/core/theme/theme_mode/text_style.dart';
import 'package:flutter/material.dart';

Column buildIconColumn(
    IconData icon, String label, Color? clrBack, Color? iconColor) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: ContainerIcon(
          colorBackground: clrBack,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
        ),
      ),
      Text(label, style: TextStyleTheme.caption)
    ],
  );
}
