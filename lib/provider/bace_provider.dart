import 'package:flutter/material.dart';

class BaceProvider extends ChangeNotifier {
  bool done=false;
  void SetDone(bool value){
    done=value;
    notifyListeners();

  }
}