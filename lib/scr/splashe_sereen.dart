import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:move_app/main.dart';
import 'package:move_app/scr/home.screen.dart';

class SplasheSereen extends StatefulWidget {
  const SplasheSereen({super.key});

  @override
  State<SplasheSereen> createState() => _SplasheSereenState();
}

class _SplasheSereenState extends State<SplasheSereen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_)=>const ScreenRote()));
  });  
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
        width: double.infinity,
        decoration: const BoxDecoration(
         color: 
        Colors.black, 
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           Text("Gamefiy",style: 
           TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
            ]
          ),
        ),
      );
  }
}