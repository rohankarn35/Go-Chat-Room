import 'package:flutter/material.dart';
import 'package:gorandom/Pages/roomOptions.dart';
import 'package:gorandom/widget/customButton.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Go Chat Room",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: const Color.fromARGB(255, 174, 33, 199),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Custombutton().customButoon(
                  height: 60,
                  width: 200,
                  color: Colors.purpleAccent.shade200,
                  textColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  fontSize: 18,
                  buttonText: 'Enter',
                  onpressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Roomoptions()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
