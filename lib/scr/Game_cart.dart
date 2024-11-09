import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:move_app/models/GameModel.dart';

import 'package:flutter/material.dart';
import 'package:move_app/scr/details_sereen.dart';

class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.gameModel});
  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
 
          onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GameDetailsScreen(id: gameModel.id)));
      },

     
      
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GridTile(
          header: Container(
            height: 60,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gameModel.genre,
                        style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        gameModel.platform.contains("Windows")
                          ? FontAwesomeIcons.computer
                          : FontAwesomeIcons.globe,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          footer: Container(
            height: 80,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    gameModel.publisher,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
            
                ],
              ),
            ),
          ),
          child: Container(
            color: Colors.black12,
            child: Image.network(
              gameModel.thumbnail,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                  ? child
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
              },
            ),
          ),
        ),
      ),
    );

  }
}

