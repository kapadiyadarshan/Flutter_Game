import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class MyAnimationController extends ChangeNotifier {
  Color myColor = Colors.grey.shade200;
  Random random = Random();
  int index = 0;
  int points = 0;
  bool isNameVisibale = false;
  ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  List Fruits = [
    "Apple",
    "Banana",
    "Grapes",
    "Orange",
    "Mango",
    "Pineapple",
    "Lichi",
    "Avacado",
    "Strawberry",
    "Watermelon",
  ];

  changeColor({required Color myColor}) {
    this.myColor = myColor;
    notifyListeners();
  }

  changeIndex() {
    index = random.nextInt(Fruits.length);
    notifyListeners();
  }

  addPoints() {
    points = points + 10;
    notifyListeners();
  }

  nameVisibility() {
    isNameVisibale = !isNameVisibale;
    notifyListeners();
  }
}
