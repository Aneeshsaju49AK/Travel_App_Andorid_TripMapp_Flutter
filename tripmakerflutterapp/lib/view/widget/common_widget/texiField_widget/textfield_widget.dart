/*this widget is used for create textfield for
signup/ and  login page */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/provider/texiFieldWidget_provider.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final void Function()? onChange;

  final TextEditingController? controller;
  final TextInputType keyboardType;

  const TextFieldWidget({
    Key? key,
    required this.label,
    this.validator,
    this.controller,
    this.onChange,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  // late TextEditingController _controller;
  final bool showError = false;

  // @override
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<TextFieldProvider>(context);
    auth.initController(controller);
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width / 1,
      height: showError ? height / 6 : height / 4.5,
      child: Column(
        children: [
          SizedBox(
            width: width / 1,
            height: showError ? height / 20 : height / 12,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                label,
                style: GoogleFonts.abel(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: width / 1.1,
              height: showError ? height / 23 : height / 10,
              child: TextFormField(
                keyboardType: keyboardType,
                controller: auth.controller,
                decoration: InputDecoration(
                  hintText: label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: validator,
                onTap: onChange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
