import 'package:flutter/material.dart';

class ProgressIndicatorController extends ChangeNotifier {

  double progressIndicator=0;
  int lengthOfFile = 0;
  double perPercent;

  void setLength(int lengt){
    this.lengthOfFile;
    this.perPercent ;
  }

  int get length_file {
    return this.lengthOfFile;
    }

  void setProgressValue(int pro,int length){
    this.lengthOfFile = length;
    this.perPercent = length/100;
    this.progressIndicator = pro/this.perPercent;
    print(this.progressIndicator);
    notifyListeners();
  }

  double get progress_indicator {
    return progressIndicator;
  }


  
}
