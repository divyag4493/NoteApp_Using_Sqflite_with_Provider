import 'package:flutter/foundation.dart';

class ListDataProvider extends ChangeNotifier{
  List<Map<String,dynamic>> _myList = [];

  List<Map<String,dynamic>> getMyList(){
    return _myList;
  }

  /// action[Events]

addData(Map<String,dynamic> newData){
    _myList.add(newData);
    notifyListeners();
}

updateData(Map<String,dynamic> dataToBeUpdated, int index){
    _myList[index] = dataToBeUpdated;
    notifyListeners();
}

deleteData(int index){
    _myList.removeAt(index);
    notifyListeners();
}

}