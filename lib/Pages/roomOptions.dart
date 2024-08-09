import 'package:flutter/material.dart';
import 'package:gorandom/Pages/createRoomPage.dart';
import 'package:gorandom/Pages/joinRoomPage.dart';
import 'package:gorandom/widget/customButton.dart';

class Roomoptions extends StatelessWidget {
  const Roomoptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Custombutton().customButoon(
                  buttonText: "Join Room",
                  height: 60,
                  width: 400,
                  color: Colors.green,
                  onpressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinRoomPage()));
                  }),
              SizedBox(
                height: 30,
              ),
              Custombutton().customButoon(
                  buttonText: "Create Room",
                  height: 60,
                  width: 400,
                  color: Colors.red,
                  onpressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateRoomPage()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
