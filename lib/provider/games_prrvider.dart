import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:move_app/helpers/api.dart';
import 'package:move_app/models/GameModel.dart';

import 'package:flutter/material.dart';
import 'package:move_app/models/gamedetalismodle.dart';

class GamesPrvider with ChangeNotifier{
    DetailedGameModel? gamedetailes;
    Api api=Api();
  List<GameModel> games = [];
    bool isShowMore = false;
      String buttonText = "Show more";
    bool isLoading =true;
  List<GameModel> similargames = [];




 
fetchGame(int id) async {
   
    final res =
        await http.get(Uri.parse("https://www.freetogame.com/api/game?id=$id"));
    if (res.statusCode == 200) {
      gamedetailes = DetailedGameModel.fromJson(jsonDecode(res.body));
      print("before ");
      print(gamedetailes!.id);
       fetchGamesByGenre(gamedetailes!.genre); 
      print("after ");
    }
  notifyListeners();

  }

  fetchGamesByPlatform(String genre) async {

        isLoading=true;
    print("before ");
    final response = await api.get("https://www.freetogame.com/api/games?platform=$genre");
    print("after ");
    if (response.statusCode == 200) {
      games.clear();
      var data = jsonDecode(response.body);
      games = List<GameModel>.from(data.map((game) => GameModel.fromJson(game)))
          .toList();
      print("the length of the games: ${games.length}");
      isLoading=false;
      notifyListeners();
     
    } else {
      print(response.statusCode);
    }

        notifyListeners();
  }



  DetailedGameModel? detailedGameModel;

  // fetchGameById(String id) async {
  //   isLoading = true;
  //   notifyListeners();
    
  //   final response =
  //       await api.get("https://www.freetogame.com/api/game?id=$id");

  //   if (response.statusCode == 200) {
  //     var decodedData = json.decode(response.body);

  //     detailedGameModel = DetailedGameModel.fromJson(decodedData);
  //     fetchGamesByGenre(gamedetailes!.genre);
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

    fetchGamesByGenre(String genre) async {

        isLoading=true;
    print("before ");
    final response = await api.get("https://www.freetogame.com/api/games?category=$genre");
    print("after ");
    if (response.statusCode == 200) {
      similargames.clear();
      var data = jsonDecode(response.body);
      similargames = List<GameModel>.from(data.map((game) => GameModel.fromJson(game)))
          .toList();
      print("the length of the games: ${games.length}");
      isLoading=false;
      notifyListeners();
     
    } else {
      print(response.statusCode);
    }

        notifyListeners();
  }

 

  
}