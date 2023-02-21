import 'package:flutter/material.dart';

class ChatState extends ChangeNotifier {
  bool _isIconPressed = false;

  bool get isIconPressed => _isIconPressed;

  void toggleIcon() {
    _isIconPressed = !_isIconPressed;
    notifyListeners();
  }
}
