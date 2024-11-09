import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:move_app/models/gamedetalismodle.dart';
import 'package:move_app/provider/games_prrvider.dart';
import 'package:move_app/scr/Game_cart.dart';
import 'package:move_app/scr/game_ge.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../models/GameModel.dart';

class GameDetailsScreen extends StatefulWidget {
  const GameDetailsScreen({super.key, required this.id});
  final int id;

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  bool isShowMore = false;
  String buttonText = "Show more";

  
  lancheextarnal(String url) async {
     if (await launchUrl( Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
     } else{
    throw Exception('Could not launch $url');
      }
  }
  


  @override
  void initState() {
    Provider.of<GamesPrvider>(context,listen: false).fetchGame(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesPrvider>(builder: (context, Gamesconsumer, _) 

      {
        return Scaffold(
          appBar: AppBar(
            title: const Text("GameDetails"),
          
          ),
           
          body:  Gamesconsumer.gamedetailes == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            Gamesconsumer.gamedetailes!.thumbnail,
                            width:400 ,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                     Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        
                         Text(Gamesconsumer.gamedetailes!.title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                       ElevatedButton(onPressed: (){
                            lancheextarnal(Gamesconsumer.gamedetailes!.gameUrl);
                          }, child: const Text("play now", ),
                       )
                      ],
                        ),
                        
        
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: Gamesconsumer.gamedetailes!.screenshots.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                    },
                                    child: Image.network(
                                      Gamesconsumer.gamedetailes!.screenshots[index].image,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        return loadingProgress != null
                                            ? const Center(
                                                child: CircularProgressIndicator(),
                                              )
                                            : child;
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 5),
                              _buildTag(Gamesconsumer.gamedetailes!.genre),
                              const SizedBox(width: 5),
                              _buildTag(Gamesconsumer.gamedetailes!.status),
                              const SizedBox(width: 5),
                              _buildTag(Gamesconsumer.gamedetailes!.platform),
                            ],
                          ),
                          Text(
                           Gamesconsumer.gamedetailes!.description,
                            maxLines: isShowMore ? 50 : 3,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isShowMore = !isShowMore;
                                buttonText = isShowMore ? "Show less" : "Show more";
                              });
                            },
                            child: Text(
                              buttonText,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          const SizedBox(height: 40),
                          if (Gamesconsumer.gamedetailes!.minimumSystemRequirements != null)
                            Text(
                              "${Gamesconsumer.gamedetailes!.minimumSystemRequirements!.graphics} \n ${Gamesconsumer.gamedetailes!.minimumSystemRequirements!.memory} \n ${Gamesconsumer.gamedetailes!.minimumSystemRequirements!.os}  \n ${Gamesconsumer.gamedetailes!.minimumSystemRequirements!.processor}\n ${Gamesconsumer.gamedetailes!.minimumSystemRequirements!.storage}",
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                               Gamesconsumer.gamedetailes!.genre,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            
                            ],
                          ),
                          SizedBox(
                            height: 400,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: min(20, Gamesconsumer.similargames.length),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GameDetailsScreen(id: Gamesconsumer.similargames[index].id),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: GameCard(gameModel:Gamesconsumer.similargames[index]),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      }
    );
  }

  Widget _buildTag(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black12,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Text(text),
      ),
    );
  }
}
