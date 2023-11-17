import 'package:flutter/cupertino.dart';

class ProgressIndicatorProvider extends ChangeNotifier{
  int currentScreenIndex=0;
  void updateScreenIndex(int index) {
    currentScreenIndex = index;
    notifyListeners();
  }

  void goBackward(){
    if (currentScreenIndex > 0) {
      updateScreenIndex(currentScreenIndex - 1);
    }
  }

  void goForward(){
    if (currentScreenIndex < 4) {
      updateScreenIndex(currentScreenIndex + 1);
    }
  }
}