import 'package:flutter/material.dart';

class AppStyleWidget {
  static ButtonStyle btnOn(context) => ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.5);
          } else if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
          return Colors.blue;
        },
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      )));
}
