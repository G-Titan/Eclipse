import 'dart:math';
import 'package:flutter/material.dart';
import 'package:eclipse/conf/func/static/LAVENDER.dart';

class EclipseAi extends StatelessWidget {
  const EclipseAi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Text(
                    'I am Lavender, built to listen to your needs & wants',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Click the sphere to begin chatting',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const LAVENDER(),
                );
              },
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 2 * pi),
                duration: const Duration(seconds: 10),
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.cyan,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset.fromDirection(
                -pi / 2,
                -100,
              ),
              child: Container(
                width: 2,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset.fromDirection(
                pi / 2,
                -100,
              ),
              child: Container(
                width: 2,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
