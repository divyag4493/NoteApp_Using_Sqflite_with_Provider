import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier{

  List<Map<String,dynamic>> arrList = [];

  void addList(Map<String,dynamic> value){
    arrList.add(value);
    notifyListeners();
  }

  void updateList(int  value){
    arrList.removeAt(value);
    notifyListeners();
  }

  List<Map<String,dynamic>> get ListShow{
    return arrList;
}




  /// Using Integer value

   int _count = 0;


  /// set value
  set countValuePlus(int value) {
    _count = _count + value;
    notifyListeners();
  }

  set countValueMinus(int value) {
    if (_count > 0) {
      _count = _count - value;
      notifyListeners();
    }
  }

  int get countValue {
    return _count;
  }
}
