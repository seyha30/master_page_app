import 'package:flutter/material.dart';

class PageData extends ChangeNotifier{
  PageData();

  int _currentPage = 0;

  void setCurrentTab(int index){
    this._currentPage = index;
    notifyListeners();
  }

  int get currentPage {
    return this._currentPage;
  }
}
