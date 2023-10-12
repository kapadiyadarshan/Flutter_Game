import 'dart:developer';

import 'package:animation_app/controller/animation_controller.dart';
import 'package:animation_app/controller/sound_controller.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reward_popup/reward_popup.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("asset/background/bg.jpg"),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Consumer<MyAnimationController>(builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Fruits Game"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      const Spacer(),
                      Text(
                        "Points: ${provider.points}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      Container(
                        height: 340,
                        width: 300,
                        alignment: Alignment.center,
                        child: DragTarget(
                          onAccept: (data) {
                            Provider.of<SoundController>(
                              context,
                              listen: false,
                            ).winSound();

                            provider.nameVisibility();
                            provider.confettiController.play();
                            provider.changeColor(myColor: Colors.transparent);
                            provider.addPoints();

                            Future.delayed(const Duration(seconds: 5), () {
                              provider.nameVisibility();
                              provider.changeColor(
                                myColor: Colors.grey.shade200,
                              );
                              provider.changeIndex();
                            });
                          },
                          onWillAccept: (data) {
                            if (data == provider.Fruits[provider.index]) {
                              return true;
                            } else {
                              Vibration.vibrate(duration: 500);
                              Provider.of<SoundController>(
                                context,
                                listen: false,
                              ).loseSound();
                              return false;
                            }
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Stack(
                              children: [
                                Image.asset(
                                  "asset/images/${provider.Fruits[provider.index]}.png",
                                  scale: 1,
                                ),
                                Image.asset(
                                  "asset/images/${provider.Fruits[provider.index]}.png",
                                  scale: 1,
                                  color: provider.myColor,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: provider.isNameVisibale,
                        child: Container(
                          height: 50,
                          width: 200,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.primaries[provider.index],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            provider.Fruits[provider.index],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      Visibility(
                        visible: !provider.isNameVisibale,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.primaries[provider.index]
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Select Fruit Name",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.primaries[provider.index],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        visible: !provider.isNameVisibale,
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: provider.Fruits.map(
                            (e) => Draggable(
                              data: e,
                              feedback: Container(
                                height: 60,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.primaries[provider.index],
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              childWhenDragging: Container(
                                height: 40,
                                width: 120,
                                color: Colors.grey.shade200,
                                margin: const EdgeInsets.all(4),
                              ),
                              child: Container(
                                height: 40,
                                width: 120,
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.primaries[provider.index],
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: provider.confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      emissionFrequency: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white70,
        );
      }),
    );
  }
}
