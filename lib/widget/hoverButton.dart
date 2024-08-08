import 'package:flutter/material.dart';
import 'package:gorandom/provider/messageProvider.dart';
import 'package:provider/provider.dart';

class HoverButton extends StatelessWidget {
  const HoverButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => context.read<Messageprovider>().isHover(true),
      onExit: (_) => context.read<Messageprovider>().isHover(false),
      child: Consumer<Messageprovider>(
        builder: (context, state, child) {
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.5),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: state.isHovered
                ? Text(
                    'Click to copy Room ID',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )
                : Icon(
                    Icons.copy,
                    color: Colors.white,
                    size: 24,
                  ),
          );
        },
      ),
    );
  }
}
