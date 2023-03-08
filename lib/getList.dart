import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class GetList{
  GetList();


  Future getList() async {
    List<Map<String,dynamic>> fetchList = [];
    final prefs = await SharedPreferences.getInstance();
    print("start getList");
    try{
      var nameList = prefs.getStringList("name");
      var boolList = prefs.getStringList("bool");

      print(nameList);
      print(boolList);

      if(nameList != null && boolList != null){

        fetchList = fetchLists(nameList,boolList);
      }else{
      }


    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }

    return fetchList;
  }

  Future setList(String n) async {
    final prefs = await SharedPreferences.getInstance();
    try{
      List<String> newNameList = prefs.getStringList("name") ?? [];
      List<String> newBoolList = prefs.getStringList("bool") ?? [];

      newNameList.add(n);
      newBoolList.add("false");

      await prefs.setStringList('name', newNameList);
      await prefs.setStringList('bool', newBoolList);

      newNameList.clear();
      newBoolList.clear();

    }catch(e){
      print(e);
    }
  }

  Future deleteListItem(i) async {
    final prefs = await SharedPreferences.getInstance();
    try{
      List<String> newNameList = prefs.getStringList("name") ?? [];
      List<String> newBoolList = prefs.getStringList("bool") ?? [];

      newNameList.removeAt(i);
      newBoolList.removeAt(i);

      await prefs.setStringList('name', newNameList);
      await prefs.setStringList('bool', newBoolList);

      newNameList.clear();
      newBoolList.clear();

      getList();

    }catch(e){
      print(e);
    }
  }



  Future changeCheckBox(i,v)async{
    final prefs = await SharedPreferences.getInstance();

    try{
      List<String> newBoolList = prefs.getStringList("bool") ?? [];

      newBoolList[i] = v.toString();

      await prefs.setStringList('bool', newBoolList);

      print(newBoolList);

      newBoolList.clear();

    }catch(e){
      print(e);
    }

  }

  List<Map<String, dynamic>> fetchLists(n,b){
    List<Map<String, dynamic>> fetchMap = [];
    fetchMap.clear();
    todoList.clear();

    for(int i = 0; i < n.length; i++){
      fetchMap.add({'content':n[i],'isFinish':b[i]});
    }

    todoList = fetchMap;

    return fetchMap;
  }
}