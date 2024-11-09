import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:move_app/helpers/Notification.dart';
import 'package:move_app/provider/auth_provider.dart';
import 'package:move_app/provider/games_prrvider.dart';
import 'package:move_app/provider/lang_provider.dart';
import 'package:move_app/scr/home.screen.dart';
import 'package:move_app/scr/login_screen.dart';
import 'package:move_app/scr/splashe_sereen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Future<void> fireBaseMeassaginBackgroundHandler(RemoteMessage message) async {
    if (kDebugMode) {
      print("BackGroundColor");
      print("Handle a background : ${message.messageId}");
      print("Notification: ${message.data}");
      print("message");
    }
  }

  FirebaseMessaging.onBackgroundMessage(fireBaseMeassaginBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print("foregrund message");
    }
    showFlutterNotification(message);
  });

  runApp(const MyApp());
}






class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GamesPrvider>(create: (context) => GamesPrvider()),
        ChangeNotifierProvider<darkmodeprovider>(create: (context) => darkmodeprovider(),),
        ChangeNotifierProvider<AuthenticationProvider>(create: (context) => AuthenticationProvider()),

      ],
      child: Consumer<darkmodeprovider>(
        builder: (context, darkMode, _) {
       
          return Consumer<GamesPrvider>(
            builder: (context,Gamesconsumer,_) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Gameify",
                   theme: ThemeData(
                 tabBarTheme: TabBarTheme(
                  labelColor:  darkMode.isdark?Colors.black:Colors.white,
                 ),
                   drawerTheme: DrawerThemeData(
                  backgroundColor:darkMode.isdark?Colors.black:Colors.white,
          
                  
                 ),
                 scaffoldBackgroundColor: 
                 darkMode.isdark?Colors.black:Colors.white,
          
                ),
                 
                home: const SplasheSereen()
                  
              );
            }
          );
        }
      ),
    );
  }
}
class ScreenRote extends StatefulWidget {
  const ScreenRote({super.key});

  @override
  State<ScreenRote> createState() => _ScreenRoteState();
}

class _ScreenRoteState extends State<ScreenRote> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return firebaseAuth.currentUser!=null?
    const HomeScreen():
    const LogInScreen();
    
    
  }
}

