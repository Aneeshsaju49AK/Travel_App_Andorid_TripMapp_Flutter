/*so this widget is made for button that can 
reuse in signup and login */
import 'package:flutter/material.dart';

class ButtonCommonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const ButtonCommonWidget({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SizedBox(
        width: width / 1.3,
        height: height / 13,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(120),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              label,
            ),
          ),
        ),
      ),
    );
  }
}
