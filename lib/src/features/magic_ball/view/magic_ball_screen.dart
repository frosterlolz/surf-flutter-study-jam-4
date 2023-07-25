import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shake/shake.dart';
import 'package:surf_practice_magic_ball/src/features/magic_ball/bloc/magic_ball_bloc.dart';

import 'package:surf_practice_magic_ball/src/utils/constants/figma_constants.dart';

const _kMainBlack = Colors.black;
const _kMainRed = Color(0xFFE61515);
const _kMainBlue = Color(0xFF01FFFF);

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen>
    with TickerProviderStateMixin {
  late final ShakeDetector _shakeDetector;
  late final AnimationController _magicBallController;
  late final AnimationController _magicPlatformController;
  late final AnimationController _answerController;
  late Color mainBallColor;
  late Color mainPlatformColor;

  @override
  void initState() {
    super.initState();
    _shakeDetector = ShakeDetector.autoStart(onPhoneShake: _onBallTap);
    _magicBallController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _answerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _magicPlatformController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    mainBallColor = _kMainBlack;
    mainPlatformColor = _kMainBlue;
  }

  void _onBallTap() {
    context.read<MagicBallBloc>().add(MagicBallEvent$Ask());
  }

  void _magicListener(BuildContext context, MagicBallState state) {
    setState(() {
      mainBallColor = _kMainBlack;
      mainPlatformColor = _kMainBlue;
    });
    switch (state) {
      case MagicBallState$InProgress():
        if (_magicBallController.isCompleted) {
          _magicBallController.reset();
          _magicBallController.forward();
        } else if (_magicBallController.isDismissed) {
          _magicBallController.forward();
        }
        break;
      case MagicBallState$Success():
        if (_answerController.isCompleted) {
          _answerController.reset();
          _answerController.forward();
        } else if (_answerController.isDismissed) {
          _answerController.forward();
        }
        break;
      case MagicBallState$Failure():
        setState(() {
          mainBallColor = _kMainRed;
          mainPlatformColor = _kMainRed;
        });
        if (_magicPlatformController.isCompleted) {
          _magicPlatformController.reset();
          _magicPlatformController.forward();
        } else if (_magicPlatformController.isDismissed) {
          _magicPlatformController.forward();
        }
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MagicBallBloc, MagicBallState>(
      listener: _magicListener,
      builder: (context, state) {
        return Container(
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
                  child: FractionallySizedBox(
                    widthFactor: 321 / kMobileWidth,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: _onBallTap,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/magic_ball/magic_ball_idle.png',
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.6,
                              child: AnimatedBuilder(
                                animation: _magicBallController,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: _magicBallController.value * 0.6,
                                    child: child,
                                  );
                                },
                                child: AnimatedBuilder(
                                    animation: _magicBallController,
                                    builder: (context, child) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorTween(
                                                    begin:
                                                        const Color(0xFF01FFFF),
                                                    end: mainBallColor,
                                                  ).evaluate(
                                                      _magicBallController) ??
                                                  const Color(0xFF01FFFF),
                                              spreadRadius: 40,
                                              blurRadius: 20,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            if (state is MagicBallState$Success)
                              FractionallySizedBox(
                                widthFactor: 0.8,
                                child: AnimatedBuilder(
                                  animation: _answerController,
                                  builder: (context, child) => Opacity(
                                    opacity: _answerController.value,
                                    child: Text(
                                      state.magicAnswer.answer,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontFamily: 'GillSans',
                                        fontWeight: FontWeight.w400,
                                        height: 32 / 36,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
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
                      AnimatedBuilder(
                          animation: _magicPlatformController,
                          builder: (context, child) {
                            return Container(
                              width: 100,
                              height: 19,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.00, 1.00),
                                  end: Alignment(0, -1),
                                  colors: [
                                    ColorTween(
                                          begin: const Color(0xFF01FFFF),
                                          end: mainBallColor,
                                        ).evaluate(_magicPlatformController) ??
                                        const Color(0xFF01FFFF),
                                    Color(0x0001FFFF)
                                  ],
                                ),
                                shape: OvalBorder(),
                              ),
                            );
                          }),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 3,
                        child: Opacity(
                          opacity: 0.7,
                          child: AnimatedBuilder(
                              animation: _magicPlatformController,
                              builder: (context, child) {
                                return Image.asset(
                                  'assets/magic_ball/front_ellipse.png',
                                  color: ColorTween(
                                    begin: const Color(0xFF01FFFF),
                                    end: mainPlatformColor,
                                  ).evaluate(_magicPlatformController),
                                );
                              }),
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
      },
    );
  }
}
