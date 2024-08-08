import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Something Unexpected Happened",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text("Plese restart the app and try again")
        ],
      )),
    );
  }
}
