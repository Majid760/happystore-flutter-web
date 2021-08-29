import 'package:flutter/material.dart';

class ProgressIndicatorController extends ChangeNotifier {

  int progressIndicator=0;

  void setProgressValue(int pro){
    this.progressIndicator = pro;
    notifyListeners();
  }

  int get progress_indicator {
    return progressIndicator;
  }


  
}
