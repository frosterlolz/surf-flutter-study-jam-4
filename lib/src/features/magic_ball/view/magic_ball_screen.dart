import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF100C2C), Color(0xFF000002)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 224
            const Spacer(
              flex: 224,
            ),
            Expanded(
              flex: 319,
              //319
              child: Image.asset(
                'assets/magic_ball/magic_ball_idle.png',
              ),
            ),
            const Spacer(
              flex: 76,
            ),
            Expanded(
              flex: 42,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 19,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, 1.00),
                        end: Alignment(0, -1),
                        colors: [Color(0xFF01FFFF), Color(0x0001FFFF)],
                      ),
                      shape: OvalBorder(),
                    ),
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: Placeholder(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment(0, -0.3),
                            colors: [
                              Color(0xFF02D0D1),
                              Color(0x00FF01C7),
                            ],
                            stops: [0, 1.5],
                            radius: 0.5,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SafeArea(
              child: Text(
                'Нажмите на шар\nили потрясите телефон',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF717171),
                  fontSize: 16,
                  fontFamily: 'GillSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
