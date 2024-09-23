// ignore_for_file: prefer_const_constructors

import 'package:chatr/authStuff/authGate.dart';
import 'package:chatr/authStuff/loginRegister.dart';
import 'package:chatr/firebase_options.dart';
import 'package:chatr/themes/DarkMode.dart';
import 'package:chatr/themes/lightMode.dart';
import 'package:chatr/themes/themeProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

