import 'package:flutter/material.dart';

class TextFieldProvider extends ChangeNotifier {
  late TextEditingController _controller;

  TextEditingController get controller => _controller;
  void initController(TextEditingController? common) {
    _controller = common ?? TextEditingController();
  }
}
