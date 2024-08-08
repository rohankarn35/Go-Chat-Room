import 'package:flutter/material.dart';
import 'package:gorandom/Pages/homepage.dart';
import 'package:gorandom/Pages/notfoundscreen.dart';
import 'package:gorandom/Pages/roomOptions.dart';

class AppRoutes {
  static const String home = "/";
  static const String room = "/room";
  static const String join = "/join";
  static const String create = "/create";
  static const String message = "/message";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => Homepage());
      case room:
        return MaterialPageRoute(builder: (context) => Roomoptions());

      default:
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
    }
  }
}
