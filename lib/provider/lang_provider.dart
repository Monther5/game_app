import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class darkmodeprovider with ChangeNotifier{
bool isdark=false;
switchmoder()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  isdark=!isdark;
  prefs.setBool("isdark", isdark);
  notifyListeners();


}
getmode()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  isdark=prefs.getBool("isdark")??false;
  notifyListeners();
}


}