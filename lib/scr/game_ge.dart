import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:move_app/models/GameModel.dart';
import 'package:move_app/scr/Game_cart.dart';

import 'package:shimmer/shimmer.dart';

class GamesGenreScreen extends StatefulWidget {
  const GamesGenreScreen({super.key, required this.value});
  final String value;

  @override
  State<GamesGenreScreen> createState() => _GamesGenreScreenState();
}

class _GamesGenreScreenState extends State<GamesGenreScreen> {
  bool isLoading = true;
  List<GameModel> games = [];
  fetchGamesByPlatform(String genre) async {
    setState(() {
      isLoading = true;
    });
    final res = await http
        .get(Uri.parse("https://www.freetogame.com/api/games?category=$genre"));
    if (res.statusCode == 200) {
      games.clear();
      var data = jsonDecode(res.body);
      games = List<GameModel>.from(data.map((game) => GameModel.fromJson(game)))
          .toList();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchGamesByPlatform(widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("genre:${widget.value}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            itemCount: isLoading ? 6 : games.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.7,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isLoading
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white38,
                            child: Container(
                              color: Colors.white,
                              height: double.infinity,
                              width: double.infinity,
                            )),
                      )
                    : GameCard(gameModel: games[index]))),
      ),
    );
  }
}