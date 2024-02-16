import 'package:chat/screen/chat_screen.dart';
import 'package:chat/screen/home_screen.dart';
import 'package:chat/screen/login_screen.dart';
import 'package:chat/screen/register_screen.dart';
import 'package:chat/screen/user_screen.dart';
import 'package:chat/shard_prf/SharedPref.dart';
import 'package:chat/themes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {




  print("Handling a background message: ${message.messageId}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  var token = await FirebaseMessaging.instance.getToken();
  print('=================');
  print(token);

  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("message recieved");
    print(event.notification!.body);
    print('ssssssss');
  });

  await SharedPref.init();





  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login_screen',
      routes: {
        '/login_screen': (context) => LoginScreen(),
        '/register_screen': (context) => RegisterScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        UserScreen.id: (context) => UserScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
