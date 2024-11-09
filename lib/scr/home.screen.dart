import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:move_app/main.dart';
import 'package:move_app/models/GameModel.dart';
import 'package:move_app/provider/auth_provider.dart';
import 'package:move_app/provider/games_prrvider.dart';
import 'package:move_app/provider/lang_provider.dart';
import 'package:move_app/scr/Game_cart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:move_app/scr/details_sereen.dart';
import 'package:move_app/scr/drower.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int nowIndex = 0;
  bool isLoading =true;

  
  @override
  void initState() {
    Provider.of<GamesPrvider>(context,listen: false).fetchGamesByPlatform("all");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<darkmodeprovider>(
      builder: (context,darkModeConsumer,_) {
        return Consumer<GamesPrvider>(
          builder: (context,Gamesconsumer,_) {
            return Scaffold(
               appBar: AppBar(
                backgroundColor:darkModeConsumer.isdark?Colors.black:Colors.white ,
               ),
                 drawer: Drawer(
                   child: SafeArea(
                     child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    DrawerTile(
                                       text: "Dark Mode",
                                        onTab: () {
                                          Provider.of<darkmodeprovider>(context,
                                                  listen: false)
                                              .switchmoder();
                                        }, icon: null,
                                      ),
                                             DrawerTile(
                                       text: "Logout",
                                        onTab: () {
                                        Provider.of<AuthenticationProvider>(context,listen:false).logout();
                                     Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_)=>const ScreenRote()));


                                        
                                             
                                        
                                        },
                                        icon: Icons.logout),
                                  ]
                                )
                     )
                   )
                 ),
                
                 
               
                                 bottomNavigationBar: BottomNavigationBar(
                    selectedLabelStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 0,
                    ),
                    onTap: (currentIndex) {
                     
                      currentIndex == 0
                      ?Gamesconsumer.fetchGamesByPlatform("all")
                      :currentIndex==1
                        ?Gamesconsumer.fetchGamesByPlatform("pc")
                        :Gamesconsumer.fetchGamesByPlatform("browser");
                    },
                    
                    currentIndex: nowIndex,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.gamepad), label: "all"),
                      BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.computer), label: "pc"),
                      BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.globe), label: "web")
                    ],
                                 ),
                                 body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                        itemCount: Gamesconsumer.isLoading?6:Gamesconsumer.games.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.7,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Gamesconsumer.isLoading
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
                                : GameCard(gameModel:Gamesconsumer.games[index]))),
                                 ),
                               );
          }
                 );
      }
               );
          }
}
   