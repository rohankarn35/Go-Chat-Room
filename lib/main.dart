import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorandom/Pages/homepage.dart';
import 'package:gorandom/core/theme.dart';
import 'package:gorandom/provider/messageProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Messageprovider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GoRandom',
          theme: AppTheme.darkThemeMode,
          home: Homepage()),
    );
  }
}
